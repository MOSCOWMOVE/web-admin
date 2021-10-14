import * as mapboxgl from "mapbox-gl";
import { LibManifestPlugin } from "webpack";
import img from "./location_pin.png";

(mapboxgl as any).accessToken = 'pk.eyJ1IjoiZmlyZXNpZWh0IiwiYSI6ImNrdW9kemYzbTB4ZGkycHAxbXN2YnIzaGMifQ.G0fl-qVbecucfOvn8OtU4Q';
        
const map = new mapboxgl.Map({
container: 'map', // container ID
style: 'mapbox://styles/mapbox/light-v10', // style URL
center: [37.61, 55.7 ], // starting position [lng, lat]
zoom: 9 // starting zoom
});





export const getCircleCords = (radius:number, steps:number, center:number[]) =>{
    let cords = []
    for (let  i = 1; i <= steps; i++) {
        let x0 = center[0]
        let y0 = center[1] 
        cords.push([
            (x0 + 1.8 * radius * Math.cos(2 * Math.PI * i / steps)),
            (y0  + radius * Math.sin(2 * Math.PI * i / steps))
        ])
    }
    return cords
}


let markers:any = []
let markers500: number[][][] = []
let markers1000: number[][][] = []
let markers3000: number[][][] = []
let markers5000: number[][][] = []
let outlines = new Array()

JSON.parse(localStorage.dots).markers.forEach((element:any) => {
    console.log(element)
})

JSON.parse(localStorage.dots).markers.forEach((dot:any) => {
    markers.push(
        {
                        // feature for Mapbox DC
                        'type': 'Feature',
                        'geometry': {
                            'type': 'Point',
                            'coordinates': dot.cords
                        },
                        'properties': {
                            'title': 'name'
                        }
                    },
    )

    if(dot.type == 500){
        let cords = getCircleCords(0.0044990383305613, 50 , dot.cords)
        markers500.push(cords)
        outlines.push({
            "type": "Feature",
            "properties": {},
            "geometry": {
                "type": "LineString",
                "coordinates": cords
            }
        })
    }
    if(dot.type == 1000){
        let cords = getCircleCords(0.008998076661122683, 50 ,  dot.cords)
        markers1000.push(cords)
        outlines.push({
            "type": "Feature",
            "properties": {},
            "geometry": {
                "type": "LineString",
                "coordinates": cords
            }
        })    }
    if(dot.type == 3000){
        let cords = getCircleCords(0.026994229983368048, 50 ,  dot.cords)
        markers3000.push(cords)
        outlines.push({
            "type": "Feature",
            "properties": {},
            "geometry": {
                "type": "LineString",
                "coordinates": cords
            }
        })    }
    if(dot.type == 5000){
        let cords = getCircleCords(0.04499038330561341, 50 ,  dot.cords)
        markers5000.push(cords)
        outlines.push({
            "type": "Feature",
            "properties": {},
            "geometry": {
                "type": "LineString",
                "coordinates": cords
            }
        })
    }
});



const geo500mjson = {
    'type': 'FeatureCollection',
    'features': [
        {
        'type': 'Feature',
        'geometry': {
                'type': 'Polygon',
                'coordinates': markers500
            }
        }
    ]
};

const geo1000mjson = {
    'type': 'FeatureCollection',
    'features': [
        {
        'type': 'Feature',
        'geometry': {
                'type': 'Polygon',
                'coordinates': markers1000
            }
        }
    ]
};

const geo3000mjson = {
    'type': 'FeatureCollection',
    'features': [
        {
        'type': 'Feature',
        'geometry': {
                'type': 'Polygon',
                'coordinates': markers3000
            }
        }
    ]
};

const geo5000mjson = {
    'type': 'FeatureCollection',
    'features': [
        {
        'type': 'Feature',
        'geometry': {
                'type': 'Polygon',
                'coordinates': markers5000
            }
        }
    ]
};

map.on('load', () => {
    map.addSource('points500m', {
        'type': 'geojson',
        'data': (geo500mjson as any)
    });
    map.addSource('points1000m', {
        'type': 'geojson',
        'data': (geo1000mjson as any)
    });
    map.addSource('points3000m', {
        'type': 'geojson',
        'data': (geo3000mjson as any)
    });
    map.addSource('points5000m', {
        'type': 'geojson',
        'data': (geo5000mjson as any)
    });


    map.addLayer(
            {
                'id': 'r500',
                'type': 'fill',
                'source': 'points500m',
                'layout': {},
                'paint': {
                    'fill-color': '#FF002E',
                    'fill-opacity': 0.25
                }
            }
        )
    map.addLayer(
            {
                'id': 'r1000',
                'type': 'fill',
                'source': 'points1000m',
                'layout': {},
                'paint': {
                    'fill-color': '#FD5C01',
                    'fill-opacity': 0.25
                }
            }
        )
    map.addLayer(
            {
                'id': 'r3000',
                'type': 'fill',
                'source': 'points3000m',
                'layout': {},
                'paint': {
                    'fill-color': '#F9C200',
                    'fill-opacity': 0.25
                }
            }
        )
    map.addLayer(
            {
                'id': 'r5000',
                'type': 'fill',
                'source': 'points5000m',
                'layout': {},
                'paint': {
                    'fill-color': '#46FF90',
                    'fill-opacity': 0.25
                }
            }
    )


    map.addLayer({
            "id": "route",
            "type": "line",
            "source": {
                "type": "geojson",
                "data": {
                    
                        'type': 'FeatureCollection',
                        'features': outlines
                    }
            },
            "paint": {
                "line-color": "#888",
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


map.on('mouseenter', 'points', () => {
map.getCanvas().style.cursor = 'pointer';
});

map.on('mouseleave', 'points', () => {
map.getCanvas().style.cursor = '';
});

