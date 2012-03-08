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
});