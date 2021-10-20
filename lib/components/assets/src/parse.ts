import {getCircleColor} from "./colorOfPoints"
import {getCircleCords} from "./getCircleCords"



export const getMarkers = () => {
    let markers:any = []
    let markersCoverage = new Array()
    let outlines = new Array()


    
    JSON.parse(JSON.parse(localStorage.localstorage_app).dots).markers.forEach((dot:any) => {
        let cords = new Array()
        let color = getCircleColor(dot.area)

        if(dot.type == 500){
            cords = getCircleCords(0.0044990383305613, 50 , dot.cords)
           
        }
        else if(dot.type == 1000){
            cords = getCircleCords(0.008998076661122683, 50 ,  dot.cords)
        }
        else if(dot.type == 3000){
            cords = getCircleCords(0.026994229983368048, 50 ,  dot.cords)
          }
        if(dot.type == 5000){
            cords = getCircleCords(0.04499038330561341, 50 ,  dot.cords)
    
        }
        markers.push(
            {
                            'type': 'Feature',
                            "id":dot.id,
                            'geometry': {
                                'type': 'Point',
                                'coordinates': dot.cords
                            },
                        },
        )
        markersCoverage.push(
            {
                'type': 'Feature',
                "properties": {
                    "color":color
                },
                'geometry': {
                        'type': 'Polygon',
                        'coordinates': [cords]
                    }
                },
                
        )
        outlines.push({
            "type": "Feature",
            "properties": {
            },
            "geometry": {
                "type": "LineString",
                "coordinates": cords
            }
        })
       
    });
    return {
        markers: markers,
        markersCoverage: markersCoverage,
        outlines: outlines,
    }
}
