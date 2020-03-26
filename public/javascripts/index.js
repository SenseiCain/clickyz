// DECLARATIONS
let caseObj, caseModel, caseColor;
let caseUrl = 'images/keyboard_case.obj';

let altKeysObj, altKeysModel, altKeysColor;
let altKeysUrl = 'images/keys_alt.obj';

let primaryKeysObj, primaryKeysModel, primaryKeysColor;
let primaryKeysUrl = 'images/keys_primary.obj';

let angleZ = 170;
let colorOptions = ['red', 'orange', 'yellow', 'green', 'blue', 'navy', 'violet', 'crimson', 'salmon'];

function preload() {
    caseModel = loadModel(caseUrl)
    altKeysModel = loadModel(altKeysUrl)
    primaryKeysModel = loadModel(primaryKeysUrl)

    caseColor = randomColor()
    altKeysColor = randomColor()
    primaryKeysColor = randomColor()
}

function setup() {
    let cnv = createCanvas(500, 400, WEBGL);
    cnv.parent('canvas-container')

    // CREATE OBJS
    caseObj = new KeyboardComponent(caseModel, caseColor)
    altKeysObj = new KeyboardComponent(altKeysModel, altKeysColor)
    primaryKeysObj = new KeyboardComponent(primaryKeysModel, primaryKeysColor)
}

function draw() {
    background('transparent');

    // LIGHTING
    directionalLight(100, 100, 100, 8, 100, 0)
    ambientLight(150)

    // TRANSFORMATIONS
    scale(1.3)
    translate(0, 0, 0)
    rotateX(radians(60))
    rotateZ(radians(angleZ))
    noStroke()
    
    // CURSOR ROTATION
    // angleZ-=0.5    

    // RENDER
    primaryKeysObj.display()
    altKeysObj.display()
    caseObj.display()
}

// KEYBOARD COMPONENT CLASS
class KeyboardComponent {
    constructor(model, color) {
        this.model = model
        this.color = color
    }

    changeColor(newColor){
        this.color = newColor
    }

    display(){
        specularMaterial(this.color)
        model(this.model)
    }
}

function randomColor(){
    let rand = Math.floor(Math.random() * colorOptions.length);
    return colorOptions[rand];
}

function updateColor(obj, color) {
    obj.color = color;
}

console.log('test')