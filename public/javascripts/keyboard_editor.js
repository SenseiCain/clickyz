    //Keyboard Components
    var key_sides = [];
    var key_tops = [];
    var keyboard_case = [];
    var keyboard_cable = [];
    var alt_key = [];

    $(document).ready(function(){
        
        function getAllKeys(){
            var all_rows = $("#keys_container").children();
            var all_keys = all_rows.map(function(i, e){
                return $(e).children()
            });

            return all_keys;
        }

        function getAllKeyTops(){
            var all_keys = getAllKeys();

            var all_tops = all_keys.map(function(i, e){
                var array = e.map(function(i, e){
                    //ff6600
                    var array = [];

                    if ($(e).css("fill") == "rgb(255, 102, 0)") {
                        array.push(e)
                    }
                    return array
                })

                var array_flat =  $.map(
                    array, 
                    function(n){
                        return n;
                    }
                );
                
                return array_flat;
            })

            key_tops = all_tops;
        }
    
        function getAllKeySides(){
            var all_keys = getAllKeys();

            var all_sides = all_keys.map(function(i, e){
                var array = e.map(function(i, e){
                    //ff6600
                    var array = [];

                    if ($(e).css("fill") == "rgb(212, 85, 0)") {
                        $(e).addClass("darker")
                        array.push(e)
                    }
                    return array
                })

                var array_flat =  $.map(
                    array, 
                    function(n){
                        return n;
                    }
                );
                
                return array_flat;
            })

            key_sides = all_sides;
        }

        function getKeyboardCase(){
            var array = []

            array.push($('#path4730')[0]);
            array.push($('#path3903')[0]);
            array.push($('#path3906')[0]);

            var array_flat =  $.map(
                array, 
                function(n){
                    return n;
                }
            );

            keyboard_case = array_flat;
        }

        function getKeyboardCable(){
            keyboard_cable = $("#cable_container #g1571").children();
        }

        //Defines Components On Load
        getAllKeySides();
        getAllKeyTops();
        getKeyboardCase();
        getKeyboardCable();

        //Override default submit
    $("#build_form").submit(function(e){
        var svg = $("#keyboard_svg");
        var svg_text = '<svg>' + svg.html() + '</svg>';

        $.post('/builds',{
            //name: params["keyboard_name"], keycaps: params["keycaps"], case: params["case"], cable: params["cable"]

            svg: svg_text,
            keyboard_name: $('#keyboard_name').val(),
            keycaps: $('#keycaps_color').val(),
            case: $('#case_color').val(),
            cable: $('#cable_color').val()

        });

      });
    });

    //Changes color of keys to set color
    function changeKeyColor(){
        var color = $('#keycaps_color').val();

        $.each(key_tops, function(i, e){
            $(e).css("fill", color)
        });

        $.each(key_sides, function(i, e){
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

    