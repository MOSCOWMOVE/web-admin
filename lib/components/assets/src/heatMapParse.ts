import { areaData } from "./areaData";
import { hslToHex } from "./colorOfPoints";

const getDisctrictColor = (dencity:number) =>{
    let maxDenstity = 30387
    let h  = 160 - (160 * dencity/maxDenstity)
    return hslToHex(h, 100, 50)
}

export const getDistrits = () => {
    localStorage.setItem("areaData", JSON.stringify(areaData))

    let districtData = require('./mo.json')
    let areaData1  = JSON.parse(localStorage.areaData)

    districtData.features.forEach((feature:any) => {
        
        areaData1.data.forEach((district:any) => {
            if (district.name == feature.properties.NAME){
                feature.properties.height = 2000 * district.density/30387
                feature.properties.color = getDisctrictColor(district.density)
            }
        });
    });
    return districtData
}

export const getSportZonesDots = () =>{
    let sportZonesData = require('./sportZones.json')

    localStorage.setItem("sportZonesData", JSON.stringify(sportZonesData))

    let dots = {
        "type": "FeatureCollection",
        "features":new Array()
    } as any

    JSON.parse(localStorage.getItem("sportZonesData")).results.forEach((dot:any) => {
        dots.features.push(
            {
                "type":"Feature",
                "properies":{
                    "square": dot.square
                },
                "geometry":{
                    "type":"Point",
                    "coordinates": [ dot.position.longitude, dot.position.latitude] 
                }
            } as any
        )
    });
    return dots
}