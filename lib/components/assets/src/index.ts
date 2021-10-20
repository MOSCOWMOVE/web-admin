import * as mapboxgl from "mapbox-gl";
import { LibManifestPlugin } from "webpack";
import { areaData } from "./areaData";
import { getDistrits, getSportZonesDots} from "./heatMapParse";
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
let sportZonesDataHeatMap = getSportZonesDots()

let markers = dataMarkers.markers
let markersCoverage = dataMarkers.markersCoverage
let outlines = dataMarkers.outlines

localStorage.setItem("showSportZonesHeatMap", "true")

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
    if (localStorage.getItem('showDistrics') == "true"){
        if (localStorage.getItem("is3D") == 'true'){
            map.addLayer({
                "id": "districts3d",
                "type": "fill-extrusion",
                "source": {
                    "type": "geojson",
                    "data": districtData 
                },
                "minzoom" : 8,
                'paint': {
                    'fill-extrusion-color': ['get', 'color'],
                    'fill-extrusion-opacity': 0.25,
                    'fill-extrusion-height': ['get', 'height']
                }    });
       
        } else{
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
        }
    }
    
    
    if(localStorage.getItem("showSportZonesHeatMap") == "true"){

        map.addLayer(
            {
                'id': 'SportZonesHeatMap',
                'type': 'heatmap',
                'source': {
                    "type": "geojson",
                    "data": sportZonesDataHeatMap
                },
                'maxzoom': 18,
                'paint': {
                    'heatmap-weight':{
                        property: 'square',
                        type: 'exponential',
                        stops: [
                          [1, 0],
                          [5000, 1]
                        ]
                      },
                   
                      'heatmap-intensity': {
                        stops: [
                          [11, 1],
                          [15, 3]
                        ]
                      },
                    // Color ramp for heatmap.  Domain is 0 (low) to 1 (high).
                    // Begin color ramp at 0-stop with a 0-transparancy color
                    // to create a blur-like effect.
                    'heatmap-color': [
                        'interpolate',
                        ['linear'],
                        ['heatmap-density'],
                        0,
                        'rgba(33,102,172,0)',
                        0.2,
                        'rgb(103,169,207)',
                        0.4,
                        'rgb(209,229,240)',
                        0.6,
                        'rgb(253,219,199)',
                        0.8,
                        'rgb(239,138,98)',
                        1,
                        'rgb(178,24,43)'
                    ],
                    // Adjust the heatmap radius by zoom level
                    'heatmap-radius': [
                        'interpolate',
                        ['linear'],
                        ['zoom'],
                        0,
                        2,
                        11,
                        20
                    ],
                    // Transition from heatmap to circle layer by zoom level
                    'heatmap-opacity': [
                        'interpolate',
                        ['linear'],
                        ['zoom'],
                        12,
                        1,
                        13,
                        0
                    ]
                }
            },
            'waterway-label'
        );

        map.addLayer(
            {
                'id': 'SportZonesHeatMap-point',
                'type': 'circle',
                'source': {
                    "type": "geojson",
                    "data": sportZonesDataHeatMap
                },
                'minzoom': 8,
                'paint': {
                    // Size circle radius by earthquake magnitude and zoom level
                    'circle-radius': [
                        'interpolate',
                        ['linear'],
                        ['zoom'],
                        7,
                        ['interpolate', ['linear'], ['get', 'mag'], 1, 1, 6, 4],
                        16,
                        ['interpolate', ['linear'], ['get', 'mag'], 1, 5, 6, 50]
                    ],
                    // Color circle by earthquake magnitude
                   

                    // Transition from heatmap to circle layer by zoom level
                    'circle-opacity': [
                        'interpolate',
                        ['linear'],
                        ['zoom'],
                        11,
                        0,
                        12,
                        1
                    ]
                }
            },
            'waterway-label'
        );
    }



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