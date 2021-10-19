import * as mapboxgl from "mapbox-gl"

export function clearMapFromPoints(map:mapboxgl.Map) {
    map.removeLayer("points")
    map.removeSource("points")
    map.removeLayer("markersCoverage")
    map.removeSource("markersCoverage")
    map.removeLayer("outlines");
    map.removeSource("outlines");
}