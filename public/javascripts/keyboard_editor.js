    //Keyboard Components
    var key_primary_sides = [];
    var key_primary_tops = [];
    var key_alt_tops = ['#path743', '#path566', '#path299', '#path5646', '#path5445', '#path5441', '#path5437', '#path5433', '#path5429', '#path5425', '#path5421', '#path5209', '#path5200', '#path5187', '#path5169', '#path5106'];
    var keyboard_case = [];
    var keyboard_cable = [];

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
                        array.push('#' + e.id)
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


            //The filter() method creates a new array with all elements that pass the test implemented by the provided function.
            //True = el not included in the key_alt array

            key_primary_tops = all_tops

            console.log('key primary top: ' + key_primary_tops[1]);
        }
    
        function getAllKeySides(){
            var all_keys = getAllKeys();

            var all_sides = all_keys.map(function(i, e){
                var array = e.map(function(i, e){
                    //ff6600
                    var array = [];

                    if ($(e).css("fill") == "rgb(212, 85, 0)") {
                        $(e).addClass("darker")
                        array.push('#' + e.id)
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

            key_primary_sides = all_sides;

            console.log('key primary side: ' + key_primary_sides[1]);
        }

        function getKeyboardCase(){
            var array = []

            array.push('#path4730');
            array.push('#path3903');
            array.push('#path3906');

            var array_flat =  $.map(
                array, 
                function(n){
                    return n;
                }
            );

            keyboard_case = array_flat;

            console.log('key case: ' + keyboard_case[1]);
        }

        function getKeyboardCable(){
            keyboard_cable = $("#cable_container #g1571").children().map(function(){
                return '#' + this.id;
            });

            console.log('key primary side: ' + keyboard_cable[1]);
        }

        //Defines Components On Load
        getAllKeySides();
        getAllKeyTops();
        getKeyboardCase();
        getKeyboardCable();

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

        $.each($(key_primary_tops), function(i, e){
            $(e).css("fill", color)
        });

        $.each(key_primary_sides, function(i, e){
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

