    //Keyboard Components
    var keycaps_primary_tops = [];
    var keycaps_primary_sides = [];
    var keycaps_alt_tops = [];
    var keycaps_alt_sides = [];
    var keyboard_case = [];
    var keyboard_cable = [];

    $(document).ready(function(){

        function findKeys(){

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
            

        }

        //Defines Components On Load
        findKeys();

        $("#build_form").submit(function(e){
            var svg = $("#keyboard_svg");

            var svg_text = '<svg>' + svg.html() + '</svg>';
    
            $('<input>').attr({
                type: 'hidden',
                name: 'svg',
                value: svg_text
            }).appendTo('#build_form');
    
            return true;
    
        });

        

        //$('#keycaps_color').mouseover(alert())
    });

    //Changes color of keys to set color
    function changeKeyColor(){
        var color = $('#keycaps_color').val();

        $.each($(keycaps_primary_tops), function(i, e){
            $(e).css("fill", color)
        });

        $.each(keycaps_primary_sides, function(i, e){
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

