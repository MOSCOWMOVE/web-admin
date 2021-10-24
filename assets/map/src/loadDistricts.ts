import * as mapboxgl from "mapbox-gl"
import { getDistrits } from "./heatMapParse";

export const loadDistrict = (map:mapboxgl.Map, is_palygon=false) => {
    let districtData = getDistrits(is_palygon);
    console.log(districtData);
    map.addSource("districts", {
        type: "geojson",
        data: districtData
    });
    map.addLayer({
        "id": "districts",
        "type": "fill",
        "source": "districts",
        "minzoom" : 8,
        'paint': {
            'fill-color': is_palygon ? "#23245C" : ['get', 'color'],
            'fill-opacity': is_palygon ? 0.8 : 0.25
        }
    });
    map.moveLayer("markersCoverage");
    map.moveLayer("points");
    map.moveLayer("outlines");
}

export const clearDistricts = (map:mapboxgl.Map) => {
    map.removeLayer("districts");
    map.removeSource("districts");
}