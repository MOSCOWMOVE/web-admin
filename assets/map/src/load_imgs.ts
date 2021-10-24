import selectIcon from "./group-selection.svg";
import areaMatch from "./area-match.svg";
import circlesMatch from "./radius-match.svg";
import heatMap from "./heat-map.svg";
import polygonLayer from "./polygon-layer.svg";

import selectIcon_active from "./group_active.svg";
import areaMatch_active from "./area_match_active.svg";
import circlesMatch_active from "./radius-match_active.svg";
import heatMap_active from "./heat_map_active.svg";
import polygonLayer_active from "./polygon_layer_active.svg";
import { modeListener, ModeListener, MODES } from "./modesListener";

export const loadImgs = () => {
    var imgs = document.getElementsByTagName("img");
    
    
    var select = document.getElementById("select") as any;
    var filter_zone = document.getElementById("filter-zone") as any;
    var circles_match = document.getElementById("circles-match") as any;
    var heat_map = document.getElementById("heat-map") as any;
    var pol_layer = document.getElementById("polygon-layer") as any;

    var a = [
        [select, selectIcon_active, selectIcon, MODES.SELECTION_MANY], 
        [filter_zone, areaMatch_active, areaMatch, MODES.GEO_SORTING], 
        [circles_match, circlesMatch_active, circlesMatch, MODES.WITHOUT_CIRCLES], 
        [heat_map, heatMap_active, heatMap, MODES.PEOPLE_DENSITY], 
        [pol_layer, polygonLayer_active, polygonLayer, MODES.POLYGON_LAYER]];
    a.map((e) => {
        e[0].onclick = () => {
            if (e[0].className == "img-clicked"){
                e[0].className = "";
                e[0].src = e[2];
                modeListener.changeMode(MODES.NONE);
                return;
            }
            e[0].className = "img-clicked";
            e[0].src = e[1];
            modeListener.changeMode(e[3]);
            a.map((ee) => {
                if (ee[1] != e[1]) {
                    ee[0].className = "";
                    ee[0].src = ee[2]
                }
            })
        }
    });

    (document.getElementById("select") as any).src = selectIcon;
    (document.getElementById("filter-zone") as any).src = areaMatch;
    (document.getElementById("circles-match") as any).src = circlesMatch;
    (document.getElementById("heat-map") as any).src = heatMap;
    (document.getElementById("polygon-layer") as any).src = polygonLayer;

}