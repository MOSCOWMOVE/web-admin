function hslToHex(h:number, s:number, l:number) {
    l /= 100;
    const a = s * Math.min(l, 1 - l) / 100;
    const f = (n:number) => {
      const k = (n + h / 30) % 12;
      const color = l - a * Math.max(Math.min(k - 3, 9 - k, 1), -1);
      return Math.round(255 * color).toString(16).padStart(2, '0'); 
    };
    return `#${f(0)}${f(8)}${f(4)}`;
  }

export const getCircleColor = (area:number) =>{
    let maxArea = 50000;
    if(area > maxArea){
        area = maxArea
    }
    let h  = 160 * area/maxArea

    return hslToHex(h, 100, 50)
}