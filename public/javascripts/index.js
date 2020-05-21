// DECLARATIONS
const caseUrl = 'images/keyboard_case.obj';
const altKeysUrl = 'images/keys_alt.obj';
const primaryKeysUrl = 'images/keys_primary.obj';

// P5 CONFIGURATIONS
const p5Config = (p) => {
    p.preload = () => {
        caseModel = p.loadModel(caseUrl)
        altKeysModel = p.loadModel(altKeysUrl)
        primaryKeysModel = p.loadModel(primaryKeysUrl)
    
        caseColor = $('#case_color').val()
        altKeysColor = $('#keycaps_alt_color').val()
        primaryKeysColor = $('#keycaps_primary_color').val()

        stopRotation = false
    }

    p.setup = () => {
        // CANVAS
        p.createCanvas(600, 400, p.WEBGL);
    
        // SLIDER
        slider = p.createSlider(0, 100)
        slider.position((p.width / 2 - 100), p.height)
        slider.style('width', '200px')
        slider.parent('canvas-container')
    
        // CREATE OBJS
        caseObj = new KeyboardComponent(caseModel, p)
        altKeysObj = new KeyboardComponent(altKeysModel, p)
        primaryKeysObj = new KeyboardComponent(primaryKeysModel, p)

    }

    p.draw = () => {
        p.background(243.1);
    
        // LIGHTING
        p.directionalLight(100, 100, 100, 8, 100, 0)
        p.ambientLight(150)
    
        // CURSOR ROTATION
        amount = (stopRotation) ? 50 : slider.value()
        angleZ = (((amount - 50) / 50) * 180) + 200
    
        // TRANSFORMATIONS
        p.scale(1.5)
        p.translate(0, -20, 0)
        p.rotateX(p.radians(60))
        p.rotateZ(p.radians(angleZ))
        p.noStroke()
    
        // RENDER
        primaryKeysObj.display(primaryKeysColor)
        altKeysObj.display(altKeysColor)
        caseObj.display(caseColor)
    }

    p.updateColor = (targetObj, newColor) => {
        switch (targetObj) {
            case 'keycaps_primary_color':
                primaryKeysColor = newColor;
                break
            case 'keycaps_alt_color':
                altKeysColor = newColor;
                break
            case 'case_color':
                caseColor = newColor;
                break
        }
    }

    p.reset = () => {
        stopRotation = true;
        p.redraw();
        p.noLoop();
    }
}

// KEYBOARD COMPONENT CLASS
class KeyboardComponent {
    constructor(model, p) {
        this.model = model
        this.p5 = p
    }

    display(color){
        this.p5.specularMaterial(color)
        this.p5.model(this.model)
    }
}

// P5 INSTANCE
let myp5 = new p5(p5Config, 'canvas-container')

// ON DOCUMENT READY
$(document).ready(function() {
    // Changes color of keyboard components
    $("#input-group select").change(e => {
        myp5.updateColor(e.target.id, e.target.value);
    });

    $('#build_form').submit(e => {
        // Reverts keyboard back to original state
        myp5.reset();

        // Data URL from Canvas
        const dataURL = $('#canvas-container canvas')[0].toDataURL('image/png');

        // Appends image data to form
        const hiddenEl = document.createElement("input");
        hiddenEl.type = "hidden";
        hiddenEl.name = "image_data"
        hiddenEl.value = dataURL;

        $("#build_form").append(hiddenEl);
    })
});