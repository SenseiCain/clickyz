    //Keyboard Components
    var keycaps_primary_tops = [];
    var keycaps_primary_sides = [];
    var keycaps_alt_tops = [];
    var keycaps_alt_sides = [];
    var keyboard_case = [];
    var keyboard_cable = [];

    $(document).ready(function(){

        //Defines Components On Load
        function findKeyboardComponents(){

            //KEYCAPS
            $("#group_keycaps_primary_tops").children().each(function(i, e){
                keycaps_primary_tops.push('#' + e.id)
            });

            $("#group_keycaps_primary_sides").children().each(function(i, e){
                keycaps_primary_sides.push('#' + e.id)
            });

            $("#group_keycaps_alt_tops").children().each(function(i, e){
                keycaps_alt_tops.push('#' + e.id)
            });

            $("#group_keycaps_alt_sides").children().each(function(i, e){
                keycaps_alt_sides.push('#' + e.id)
            });

            //CASE
            $("#group_case").children().each(function(i, e){
                keyboard_case.push('#' + e.id)
            });

            //CABLE
            $("#group_cable").children().each(function(i, e){
                keyboard_cable.push('#' + e.id)
            });
            
        }

        //Sets keyboard Vars & SVG onLoad
        findKeyboardComponents();
        changeKeyPrimaryColor();
        changeKeyAltColor();
        changeCaseColor();
        changeCableColor();

        //Adds keyboard data to submit form
        $("#build_form").submit(function(e){
            var svg = $("#keyboard_svg");

            var svg_text = svg.html();
    
            $('<input>').attr({
                type: 'hidden',
                name: 'svg',
                value: svg_text
            }).appendTo('#build_form');
    
            return true;
        });

    });

    //Change color of SVG components
    function changeKeyPrimaryColor(){
        var color = $('#keycaps_primary_color').val();

        $.each($(keycaps_primary_tops), function(i, e){
            $(e).css("fill", color)
        });

        $.each(keycaps_primary_sides, function(i, e){
            $(e).css("fill", color)
        });

        console.log('test')
    };

    function changeKeyAltColor(){
        var color = $('#keycaps_alt_color').val();

        $.each($(keycaps_alt_tops), function(i, e){
            $(e).css("fill", color)
        });

        $.each(keycaps_alt_sides, function(i, e){
            $(e).css("fill", color)
        });
    };

    function changeCaseColor(){
        var color = $('#case_color').val();

        $.each(keyboard_case, function(i, e){
            $(e).css("fill", color)
        });
    };

    function changeCableColor(){
        var color = $('#cable_color').val();

        $.each(keyboard_cable, function(i, e){
            $(e).css("stroke", color)
        });

    }
