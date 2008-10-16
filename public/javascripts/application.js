// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function pledge_awesomeness( total_points ) {
  var current_awesomeness_level;
  $('.awesomeness .score').hide().each( function() { 
    if( new Number( $(this).attr('data-threshold') ) <= total_points ) { 
      current_awesomeness_level = this;
    }
  } );

  if ( current_awesomeness_level !== undefined ) {
    $(current_awesomeness_level).show();
  }
}
function pledge_scoring() {
      var total = 5;
      var total_points = 0;

      $('.mode_of_transport .pledge_size:checked').each(function() {
        if( new Number( $(this).val() ) >  0 ) { total = total - new Number($(this).val()); }
        total_points += new Number( $(this).attr('data-points'));
      });
      pledge_awesomeness.call(this, total_points );

      $('.mode_of_transport').each( function() {
        var row_value = $('.pledge_size:checked', this ).val() || 0;    
        var limit = new Number( row_value ) + ( total );

        $('.pledge_size', this).each( function() { 
          var item_value = new Number( $(this).val());
          if( item_value > limit ) {
            $(this).attr('disabled', true );
            $(this).parent('.pledge_size_container').addClass('disabled');
          } else {
            $(this).attr('disabled', 0 );
            $(this).parent('.pledge_size_container').removeClass('disabled');
          }
          if( item_value <= row_value && item_value != 0 ) { 
            $(this).parent('.pledge_size_container').addClass('active');
          } else {
            $(this).parent('.pledge_size_container').removeClass('active');
          }
        });
      });


}

  
  
