import * as mapboxgl from "mapbox-gl";
import { getDistrits } from "./heatMapParse";
import img from "./location_pin.png";
import active_img from "./active_pin.png";
import {getMarkers} from "./parse"
import {clearMapFromPoints} from "./clearMap";
import {loadPointsToMap} from "./mapInit";
import {loadImgs} from "./load_imgs";
import { modeListener, MODES } from "./modesListener";
import { clearDistricts, loadDistrict } from "./loadDistricts";
import {Drawer} from "./draw";

localStorage.clear()
localStorage.setItem("darkTheme", "false")
loadImgs();
console.log(img);

var selection_many = false;

document.addEventListener("keypress", (e) => {
    if (e.ctrlKey) {
        selection_many = true;
    }
})

export interface IArea{
    id:string, cords:number[], type:number, area:number
}


var points:IArea[] = [
];


window.onmessage = (e) => {
    let dataMarkers = getMarkers((e.data.markers as IArea[]))
    points = e.data.markers as IArea[];
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


const map = new mapboxgl.Map({
    container: 'map', // container ID
    style: localStorage.blackTheme == "true"? 'mapbox://styles/mapbox/dark-v10' :'mapbox://styles/mapbox/light-v10', // style URL
    center: [37.61, 55.7 ], // starting position [lng, lat]
    zoom: 9 // starting zoom
});

let districtData = getDistrits()




map.on('load', () => {

    map.loadImage(
        img,
        (error, image) => {
            if (error) throw error;
            map.addImage('custom-marker', image);
            // Add a GeoJSON source with 2 points
        }
    );
    map.loadImage(
        active_img,
        (error, image) => {
            if (error) {
                throw new Error()
            }
            map.addImage("active-marker", image);
        }
    )

    loadPointsToMap(map, points);

});

map.on('click', 'points', (e) => { 
    console.log(localStorage.getItem("activePoint"))
    if (e.features[0].geometry.type == "Point"){
        if (selection_many) {
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
    clearMapFromPoints(map);
    loadPointsToMap(map, points);
    
 
});
map.on('mouseenter', 'points', () => {
    map.getCanvas().style.cursor = 'pointer';
});

map.on('mouseleave', 'points', () => {
    map.getCanvas().style.cursor = '';
})

map.on("mousedown", (e) => {
    console.log(e.lngLat);
})
map.on("mouseup", (e) => {

    console.log(e.lngLat, "up")
})

modeListener.addListener((mode) => {
    console.log(mode);
    switch(mode) {
        case MODES.SELECTION_MANY:
            selection_many = true;
            break
        case MODES.NONE:
            selection_many = false
            try{
                clearDistricts(map)
            } catch{}
            
            try{
                clearMapFromPoints(map);
            } catch{}
            
            loadPointsToMap(map, points);
            break;
        case MODES.PEOPLE_DENSITY:
            loadDistrict(map);
            break;
        case MODES.POLYGON_LAYER:
            loadDistrict(map, true)
            clearMapFromPoints(map)
            loadPointsToMap(map, points, true, true);
            break;
        case MODES.WITHOUT_CIRCLES:
            clearMapFromPoints(map)
            loadPointsToMap(map, points, false, false)
        default:
            break
    }
})