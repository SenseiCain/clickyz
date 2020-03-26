// DECLARATIONS
let caseObj, caseModel, caseColor;
let caseUrl = 'images/keyboard_case.obj';

let altKeysObj, altKeysModel, altKeysColor;
let altKeysUrl = 'images/keys_alt.obj';

let primaryKeysObj, primaryKeysModel, primaryKeysColor;
let primaryKeysUrl = 'images/keys_primary.obj';

let angleZ = -160;
let colorOptions = ['red', 'orange', 'yellow', 'green', 'blue', 'navy', 'violet', 'crimson', 'salmon'];


// P5 CONFIGURATIONS
function preload() {
    caseModel = loadModel(caseUrl)
    altKeysModel = loadModel(altKeysUrl)
    primaryKeysModel = loadModel(primaryKeysUrl)

    caseColor = $('#case_color').val()
    altKeysColor = $('#keycaps_alt_color').val()
    primaryKeysColor = $('#keycaps_primary_color').val()
}

function setup() {
    let cnv = createCanvas(600, 400, WEBGL);
    cnv.parent('canvas-container');

    // CREATE OBJS
    caseObj = new KeyboardComponent(caseModel, caseColor)
    altKeysObj = new KeyboardComponent(altKeysModel, altKeysColor)
    primaryKeysObj = new KeyboardComponent(primaryKeysModel, primaryKeysColor)
}

function draw() {
    $('canvas').css("transform", "scaleX(-1)")
    background(243.1);

    // LIGHTING
    directionalLight(100, 100, 100, 8, 100, 0)
    ambientLight(150)

    // TRANSFORMATIONS
    scale(1.5)
    translate(0, -20, 0)
    rotateX(radians(60))
    rotateZ(radians(angleZ))
    noStroke()
    
    // CURSOR ROTATION
    // angleZ+=0.5    

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


// FUNCTIONS
function changeColor(e) {
    let selectedObj;
    let targetId = e.target.id;

    switch (targetId) {
        case 'keycaps_primary_color':
            selectedObj = primaryKeysObj;
            break
        case 'keycaps_alt_color':
            selectedObj = altKeysObj;
            break
        case 'case_color':
            selectedObj = caseObj;
            break
    }

    selectedObj.color = e.target.value
}


// ON DOCUMENT READY
$(document).ready(function() {
    $("#input-group select").change(changeColor);
  });