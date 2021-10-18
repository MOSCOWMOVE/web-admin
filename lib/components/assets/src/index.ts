import * as mapboxgl from "mapbox-gl";
import { LibManifestPlugin } from "webpack";
import { areaData } from "./areaData";
import { getDistrits } from "./heatMapParse";
import img from "./location_pin.png";
import {getMarkers} from "./parse"


(mapboxgl as any).accessToken = 'pk.eyJ1IjoiZmlyZXNpZWh0IiwiYSI6ImNrdW9kemYzbTB4ZGkycHAxbXN2YnIzaGMifQ.G0fl-qVbecucfOvn8OtU4Q';

 let districs = getDistrits()

 
const map = new mapboxgl.Map({
    container: 'map', // container ID
    style: localStorage.blackTheme == "true"? 'mapbox://styles/mapbox/dark-v10' :'mapbox://styles/mapbox/light-v10', // style URL
    center: [37.61, 55.7 ], // starting position [lng, lat]
    zoom: 9 // starting zoom
});

let dataMarkers = getMarkers()
let districtData = getDistrits()


let markers = dataMarkers.markers
let markersCoverage = dataMarkers.markersCoverage
let outlines = dataMarkers.outlines

console.log(markersCoverage)

map.on('load', () => {
    if (localStorage.getItem("blackTheme") != "true"){
        map.addSource('markersCoverage', {
            'type': 'geojson',
            'data': {
                'type': 'FeatureCollection',
                'features': markersCoverage
            }
    });
       
    
    
    map.addLayer(
                {
                    'id': 'markersCoverage',
                    'type': 'fill',
                    'source': 'markersCoverage',
                    'layout': {},
                    "minzoom" : 8,
                    'paint': {
                        'fill-color':["get", "color"],
                        'fill-opacity': 0.25
                    }
                }
            )
        
    }
   
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

    map.addLayer({
            "id": "outlines",
            "type": "line",
            "source": {
                "type": "geojson",
                "data": {
                    
                        'type': 'FeatureCollection',
                        'features': outlines
                    }
            },
            "minzoom" : 8,
            "paint": {
                "line-color": localStorage.getItem("blackTheme") == "true"? "#2B2DBA": "#888",
               
                "line-width": 3,
                "line-dasharray": [4, 4]
            }
        });

    map.loadImage(
        img,
        (error, image) => {
            if (error) throw error;
            map.addImage('custom-marker', image);
            // Add a GeoJSON source with 2 points
            map.addSource('points', {
                'type': 'geojson',
                'data': {
                    'type': 'FeatureCollection',
                    'features': markers
                }
            });

            // Add a symbol layer
            map.addLayer({
                'id': 'points',
                'type': 'symbol',
                'source': 'points',
                'layout': {
                    'icon-image': 'custom-marker',
                    // get the title name from the source's "title" property
                    'text-field': ['get', 'title'],
                    'text-font': [
                        'Open Sans Semibold',
                        'Arial Unicode MS Bold'
                    ],
                    'text-offset': [0, 1.25],
                    'text-anchor': 'top'
                }
            });

        }
    );
});

map.on('click', 'markersCoverage', (e) => { 
    if (e.features[0].geometry.type == "Point"){
        localStorage.activePoint = JSON.stringify({active:true, id: e.features[0].id})
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
});