import MapboxDraw from "@mapbox/mapbox-gl-draw";
import DrawRectangle, {
  DrawStyles,
} from "mapbox-gl-draw-rectangle-restrict-area";


export function drawEnable(map) {
    const draw = new MapboxDraw({
        userProperties: true,
        displayControlsDefault: false,
        styles: DrawStyles,
        modes: Object.assign(MapboxDraw.modes, {
          draw_rectangle: DrawRectangle,
        }),
    });

    map.addControl(draw);
    draw.changeMode("draw_rectangle", {
        areaLimit: 5 * 1_000_000, // 5 km2, optional
        escapeKeyStopsDrawing: true, // default true
        allowCreateExceeded: false, // default false
        exceedCallsOnEachMove: false, // default false
        exceedCallback: (area) => console.log("exceeded!", area), // optional
        areaChangedCallback: (area) => console.log("updated", area), // optional
    });
}

export class Drawer{
    draw = new MapboxDraw({
        userProperties: true,
        displayControlsDefault: false,
        styles: DrawStyles,
        modes: Object.assign(MapboxDraw.modes, {
          draw_rectangle: DrawRectangle,
          init: ""
        }),
    });

    constructor(map) {
        map.addControl(this.draw)
    }
    enableDraw() {
        this.draw.changeMode("draw_rectangle", {
            areaLimit: 5 * 1_000_000, // 5 km2, optional
            escapeKeyStopsDrawing: true, // default true
            allowCreateExceeded: false, // default false
            exceedCallsOnEachMove: false, // default false
            exceedCallback: (area) => console.log("exceeded!", area), // optional
            areaChangedCallback: (area) => console.log("updated", area), // optional
        });
    }
    disableDraw() {
        console.log(this.draw, this.draw.modes);
        this.draw.delete()
        //this.draw.changeMode("init");
    }
}