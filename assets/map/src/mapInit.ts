import * as mapboxgl from "mapbox-gl";
import { IArea } from ".";
import { getMarkers } from "./parse";

export function loadPointsToMap(map:mapboxgl.Map, inputs:IArea[]) {
    let dataMarkers = getMarkers(inputs);
    let markers = dataMarkers.markers
    let markersCoverage = dataMarkers.markersCoverage
    let outlines = dataMarkers.outlines
    if (localStorage.getItem("blackTheme") != "true"){
        map.addSource('markersCoverage', {
            'type': 'geojson',
            'data': {
                'type': 'FeatureCollection',
                'features': markersCoverage}
        })
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
    map.addSource('points', {
        'type': 'geojson',
        'data': {
            'type': 'FeatureCollection',
            'features': markers
        }
    });
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