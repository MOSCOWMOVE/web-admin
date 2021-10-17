import * as mapboxgl from "mapbox-gl";

import { MARKER_TYPES } from "./marker_types";
import pin_img from "./images/location_pin.png";

export class Map{
    map_instance:mapboxgl.Map;
    markers:any = [];
    

    constructor(token: string, darkTheme:boolean) {
        this.createMap(token, darkTheme)
    }

    createMap(token:string, darkTheme:boolean) {
        (mapboxgl as any).accessToken = token;

        const style = darkTheme ? 'mapbox://styles/mapbox/dark-v10' : 'mapbox://styles/mapbox/light-v10'

        this.map_instance = new mapboxgl.Map(
            {
                container: "map",
                style: style,
                center: [37.61, 55.7 ],
                zoom: 9
            }
        )
    }

    loadImages() {
        this.map_instance.addImage(
            "custom-marker", pin_img,
        )
    }

    drawPoint(type:MARKER_TYPES, cords:{long:number, latt:number}) {
    }
}