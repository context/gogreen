// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function pledge_awesomeness( total_points ) {
  var current_awesomeness_level;
  $('.awesomeness .score').hide().each( function() { 
    $('.awesomeness .statcontentbottombg').removeClass( 'score-' + $(this).attr('data-level'));
    if( new Number( $(this).attr('data-threshold') ) <= total_points ) { 
      current_awesomeness_level = $(this).attr('data-level');
    }
  } );

  if ( current_awesomeness_level !== undefined ) {
    //$(current_awesomeness_level).show();
    $('.awesomeness .statcontentbottombg').addClass( 'score-' + current_awesomeness_level );
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
        for( i = 0; i <= 5; i++ ) {
          $('.days_block', this).removeClass('days_' + i );
        }
        $('.days_block', this).addClass('days_' + row_value);
        if( row_value > 0 ) {
          $('.days_block_start', this).addClass('days_block_start_active');
        } else {
          $('.days_block_start', this).removeClass('days_block_start_active');
        }
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

  
  
