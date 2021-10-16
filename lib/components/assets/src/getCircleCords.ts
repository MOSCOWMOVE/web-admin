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
