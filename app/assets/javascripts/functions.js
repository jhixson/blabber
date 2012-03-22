var chart1;
$('div[data-role="page"]').live('pageinit', function() {
  $('input[name=choose_category]').unbind('click');
  $('input[name=choose_category]').click(function() {
    var id = $('#category_id').val();
    //window.location.href = '/categories/'+id+'/subcategories';
    $.mobile.changePage('/categories/'+id+'/subcategories');
  });
  
  $('a.comment_vote').unbind('click');
  $('a.comment_vote').click(function(e) {
    e.preventDefault();
    e.stopPropagation();
    var link = $(this);
    $.post(link.attr('href'), function(result) {
      console.log(result);
      var res = parseInt(result) || 0;
      link.closest('.comment').find('.plusminus').text('('+res+')');
    });
  });

  $('a.heart').unbind('click');
  $('a.heart').click(function(e) {
    e.preventDefault();
    e.stopPropagation();
    var link = $(this);
    link.toggleClass('active');
    $.get(link.attr('href'), function(result) {
      console.log(result);
      
    });
  });

  $('#theCounter').textCounter({
    target: '#comment_comment_text' // required: string
  });

  $('a#post_comment').unbind('click');
  $('a#post_comment').click(function(e) {
    e.preventDefault();
    e.stopPropagation();
    var link = $(this);
    //$(this).closest('form').submit();
    $.post(link.attr('href'), $(this).closest('form').serialize(), function(result) {
      //window.location.reload(true);
      var res = parseInt(result) || 0;
      //$.mobile.changePage('/events/'+res, {'transition':'slide'}, true, false);
      window.location.href = '/events/'+res;
    });
  });

  $('a.thumb').unbind('click');
  $('a.thumb').click(function(e) {
    e.preventDefault();
    e.stopPropagation();
    var link = $(this);
    $.post('/comments', $('#new_comment').serialize(), function(result) {
      $.post(link.attr('href'), function(result) {
        //window.location.reload(true);
        var res = parseInt(result) || 0;
        //$.mobile.changePage('/events/'+res, {'transition':'slide'}, true, false);
        var body = 'I just rated the class ' + $('#headertext').text() + ' at RateMyClass.com. ' + $('#comment_comment_text').val();
        if(body == '')
          body = 'I just rated the class ' + $('#headertext').text() + ' at RateMyClass.com';
        if($('.facebook_share').is('.active')) {
          FB.api('/me/feed', 'post', { message: body }, function(response) {
            if (!response || response.error) {
              console.log(response);
              alert('There was a problem, please try again.')
            } 
            else {
              console.log('Post ID: ' + response.id);
              window.location.href = '/events/'+res;
            }
          });
        }
        else
          window.location.href = '/events/'+res;
      });
    });
  });

  $('a.facebook_share').unbind('click');
  $('a.facebook_share').click(function() {
    $(this).toggleClass('active');
    FB.login(function(response) {
     if (response.authResponse) {
       console.log('Welcome!  Fetching your information.... ');
       FB.api('/me', function(response) {
         console.log('Good to see you, ' + response.name + '.');
       });
     } else {
       console.log('User cancelled login or did not fully authorize.');
       window.location.href = '/users/sign_in';
     }
   },{'scope':'publish_stream'});
  });

  $('a.twitter_share').unbind('click');
  $('a.twitter_share').click(function() {
    $(this).toggleClass('active');
  });


  $('a#submit_send').unbind('click');
  $('a#submit_send').click(function(e) {
    e.preventDefault();
    e.stopPropagation();
    var link = $(this);
    link.closest('form').submit();
  });

  if (window.location.hash == "#_=_")
        window.location.hash = "";
});

if (!window.console) {
  window.console = {
    log: function() {},
    error: function() {},
    warn: function() {}
  };
}