export enum MODES {
    WITHOUT_CIRCLES, 
    PEOPLE_DENSITY,
    POLYGON_LAYER,
    GEO_SORTING,
    SELECTION_MANY,
    NONE
}


export class ModeListener{
    mode: MODES = MODES.NONE;

    funcs:((mode:MODES)=>void)[] = [];

    addListener(func:(mode:MODES)=>void) {
        this.funcs.push(func);
    }

    changeMode(mode:MODES) {
        console.log(mode, this.funcs);
        this.mode = mode;
        this.funcs.map((e) => {
            e(this.mode);
        })
    }

}

export const modeListener = new ModeListener();