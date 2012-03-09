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
    $.get(link.attr('href'), function(result) {
      console.log(result);
      link.toggleClass('active');
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
      $.mobile.changePage('/events/'+res, {'transition':'slide'}, true, false);
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
        $.mobile.changePage('/events/'+res, {'transition':'slide'}, true, false);
      });
    });
  });

  if (window.location.hash == "#_=_")
        window.location.hash = "";
});