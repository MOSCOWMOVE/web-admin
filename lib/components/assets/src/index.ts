import * as mapboxgl from "mapbox-gl";
import img from "./location_pin.png";

(mapboxgl as any).accessToken = 'pk.eyJ1IjoiZmlyZXNpZWh0IiwiYSI6ImNrdW9kemYzbTB4ZGkycHAxbXN2YnIzaGMifQ.G0fl-qVbecucfOvn8OtU4Q';
        
const map = new mapboxgl.Map({
container: 'map', // container ID
style: 'mapbox://styles/mapbox/light-v10', // style URL
center: [37.61, 55.7 ], // starting position [lng, lat]
zoom: 9 // starting zoom
});

let dots = { 
    markers: [
            [37.65, 55.88],
            [37.55, 55.75],
            [37.80, 55.69],
        ]
    }
                
localStorage.dots = JSON.stringify(dots)

let markers:any = []

JSON.parse(localStorage.dots).markers.forEach((dot:any) => {
    markers.push(
        {
                        // feature for Mapbox DC
                        'type': 'Feature',
                        'geometry': {
                            'type': 'Point',
                            'coordinates': dot
                        },
                        'properties': {
                            'title': 'name'
                        }
                    },
    )
});


const geo500mjson = {
    'type': 'FeatureCollection',
    'features': [
        {
        'type': 'Feature',
        'geometry': {
                'type': 'Point',
                'coordinates': [37.65, 55.88]
            }
        }
    ]
};

map.on('load', () => {

map.addSource('point', {
        'type': 'geojson',
        'data': (geo500mjson as any)
        });
        map.addLayer(
            {
                'id': 'r500',
                'type': 'circle',
                'source': 'point',
                'paint': {
                'circle-radius': 15,
                'circle-color': '#F84C4C' // red color
                }
            }
        )



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


map.on('mouseenter', 'points', () => {
map.getCanvas().style.cursor = 'pointer';
});

map.on('mouseleave', 'points', () => {
map.getCanvas().style.cursor = '';
});

