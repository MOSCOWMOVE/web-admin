import * as mapboxgl from "mapbox-gl";
import { getDistrits } from "./heatMapParse";
import img from "./location_pin.png";
import {getMarkers} from "./parse"
import {clearMapFromPoints} from "./clearMap";
import {loadPointsToMap} from "./mapInit";


export interface IArea{
    id:string, cords:number[], type:number, area:number
}


window.onmessage = (e) => {
    let dataMarkers = getMarkers((e.data.markers as IArea[]))
    let markers = dataMarkers.markers
    let markersCoverage = dataMarkers.markersCoverage
    let outlines = dataMarkers.outlines
    try{
        clearMapFromPoints(map);
    }catch{}
    
    loadPointsToMap(map, (e.data.markers as IArea[]));
}


(mapboxgl as any).accessToken = 'pk.eyJ1IjoiZmlyZXNpZWh0IiwiYSI6ImNrdW9kemYzbTB4ZGkycHAxbXN2YnIzaGMifQ.G0fl-qVbecucfOvn8OtU4Q';
localStorage.setItem("blackTheme", "false");

 let districs = getDistrits()

const map = new mapboxgl.Map({
    container: 'map', // container ID
    style: localStorage.blackTheme == "true"? 'mapbox://styles/mapbox/dark-v10' :'mapbox://styles/mapbox/light-v10', // style URL
    center: [37.61, 55.7 ], // starting position [lng, lat]
    zoom: 9 // starting zoom
});

let districtData = getDistrits()





map.on('load', () => {
    map.addLayer({
        "id": "districts",
        "type": "fill",
        "source": {
            "type": "geojson",
            "data": districtData 
        },
        "minzoom" : 8,
        'paint': {
            'fill-color': ['get', 'color'],
            'fill-opacity': 0.25
        }
    });


    map.loadImage(
        img,
        (error, image) => {
            if (error) throw error;
            map.addImage('custom-marker', image);
            // Add a GeoJSON source with 2 points
        }
    );

});

map.on('click', 'points', (e) => { 
    console.log(localStorage.getItem("activePoint"))
    if (e.features[0].geometry.type == "Point"){
        if (e.originalEvent.ctrlKey) {
            localStorage.setItem("activePoint", localStorage.getItem("activePoint")+","+e.features[0].id);
        }
        else {
            localStorage.activePoint = e.features[0].id

        }
        window.parent.postMessage(localStorage.getItem("activePoint"), "*");
        map.flyTo({
            center: [e.features[0].geometry.coordinates[0], e.features[0].geometry.coordinates[1]]
            });
    }
    
 
});
map.on('mouseenter', 'points', () => {
    map.getCanvas().style.cursor = 'pointer';
});

map.on('mouseleave', 'points', () => {
    map.getCanvas().style.cursor = '';
})