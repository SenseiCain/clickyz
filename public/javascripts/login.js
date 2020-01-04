function changeToRegistration(){
    var html = "<div class='form-group'> <input type='text' name='username' id='username' class='form-control' placeholder='Username' required='required'> </div>" 

    $('#login-form').attr('action', '/register');
    $(html).hide().prependTo("#input-groups").fadeIn();
    $("#register_btn").fadeOut();
}