import { areaData } from "./areaData";
import { hslToHex } from "./colorOfPoints";

const getDisctrictColor = (dencity:number) =>{
    let maxDenstity = 30387
    let h  = 160 - (160 * dencity/maxDenstity)
    return hslToHex(h, 100, 50)
}

export const getDistrits = (is_polygon:boolean=false) => {
    console.log(is_polygon);
    localStorage.setItem("areaData", JSON.stringify(areaData))

    let districtData = require('./mo.json')
    let areaData1  = JSON.parse(localStorage.areaData)

    if (is_polygon == true) {
        districtData.features.forEach((feature:any) => {
            feature.properties.color == "#23345C";
        })
        
        return districtData;
    }

    districtData.features.forEach((feature:any) => {
        
        areaData1.data.forEach((district:any) => {
            if (district.name == feature.properties.NAME){
                feature.properties.color = is_polygon ? "#23245C" : getDisctrictColor(district.density)
            }
        });
        if (!feature.properties.color) {
            feature.properties.color = is_polygon ? "#23245C" : getDisctrictColor(17906.4)
        }
        
    });
    return districtData
}

