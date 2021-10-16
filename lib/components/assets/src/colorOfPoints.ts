function HSVtoRGB(h:number, s:number, v:number) {
    var r, g, b, i, f, p, q, t;

    i = Math.floor(h * 6);
    f = h * 6 - i;
    p = v * (1 - s);
    q = v * (1 - f * s);
    t = v * (1 - (1 - f) * s);
    switch (i % 6) {
        case 0: r = v, g = t, b = p; break;
        case 1: r = q, g = v, b = p; break;
        case 2: r = p, g = v, b = t; break;
        case 3: r = p, g = q, b = v; break;
        case 4: r = t, g = p, b = v; break;
        case 5: r = v, g = p, b = q; break;
    }
    return {
        r: Math.round(r * 255),
        g: Math.round(g * 255),
        b: Math.round(b * 255)
    };
}

function componentToHex(c:any) {
    var hex = c.toString(16);
    return hex.length == 1 ? "0" + hex : hex;
  }
  
  function rgbToHex(r:number, g:number, b:number) {
    return "#" + componentToHex(r) + componentToHex(g) + componentToHex(b);
  }

export const getCircleColor = (area:number) =>{
    let maxArea = 50000;
    if(area > maxArea){
        area = maxArea
    }
    let h  = 160 * area/maxArea
    let rgb = HSVtoRGB(h, 1,1)
    return rgbToHex(rgb.r, rgb.g, rgb.b)
}