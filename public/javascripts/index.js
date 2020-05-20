// DECLARATIONS
let caseObj, caseModel, caseColor;
let caseUrl = 'images/keyboard_case.obj';

let altKeysObj, altKeysModel, altKeysColor;
let altKeysUrl = 'images/keys_alt.obj';

let primaryKeysObj, primaryKeysModel, primaryKeysColor;
let primaryKeysUrl = 'images/keys_primary.obj';

let cnv;
let slider;
let angleZ;


// P5 CONFIGURATION
function preload() {
    caseModel = loadModel(caseUrl)
    altKeysModel = loadModel(altKeysUrl)
    primaryKeysModel = loadModel(primaryKeysUrl)

    caseColor = $('#case_color').val()
    altKeysColor = $('#keycaps_alt_color').val()
    primaryKeysColor = $('#keycaps_primary_color').val()
}

function setup() {
    // CANVAS
    cnv = createCanvas(600, 400, WEBGL);
    cnv.parent('canvas-container');

    // SLIDER
    slider = createSlider(0, 100)
    slider.position((width / 2 - 100), height)
    slider.style('width', '200px')
    slider.parent('canvas-container')

    // CREATE OBJS
    caseObj = new KeyboardComponent(caseModel, caseColor)
    altKeysObj = new KeyboardComponent(altKeysModel, altKeysColor)
    primaryKeysObj = new KeyboardComponent(primaryKeysModel, primaryKeysColor)
}

function draw() {
    background(243.1);

    // LIGHTING
    directionalLight(100, 100, 100, 8, 100, 0)
    ambientLight(150)

    // CURSOR ROTATION
    angleZ = (((slider.value() - 50) / 50) * 180) + 160

    // TRANSFORMATIONS
    scale(1.5)
    translate(0, -20, 0)
    rotateX(radians(60))
    rotateZ(radians(angleZ))
    noStroke()

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

    $('#build_form').submit(e => {

        // Data URL from Canvas
        const dataURL = $('#canvas-container canvas')[0].toDataURL('image/png');

        const hiddenEl = document.createElement("input");
        hiddenEl.type = "hidden";
        hiddenEl.name = "image_data"
        hiddenEl.value = dataURL;

        $("#build_form").append(hiddenEl);
    })
});




