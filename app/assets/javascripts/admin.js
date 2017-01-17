$(document).on('turbolinks:load', function() {
  $('body').on('click', '#new_category', function() {
    $form = $(this);
    $parent_id = $("#parent_category").val();
    $selected_parent = $("#parent_category")[0].selectedIndex;
    $parent_tr = '';
    $data = '';
    $form.submit(function(e) {
      e.preventDefault();
      e.stopImmediatePropagation();
      $.ajax({
        dataType: 'html',
        method: $form.attr('method'),
        url: $form.attr('action'),
        data: $form.serialize(),
        success: function(data) {
          $new_row = $('' + data),
          $new_id = $new_row.attr('id').split('_')[1],
          $new_val = $new_row.children().first().text().trim()
          if (data == null) {
            alert(I18n.t('error'));
          }
          if ($parent_id.length == 0) {
            $('#categories tr:last').after($new_row);
            $('#parent_category').append($('<option>', {
              value: $new_id,
              text: $new_val
            }));
          } else {
            $('#parent_category option').eq($selected_parent).after($('<option>',
              {value: $new_id, text: $new_val}));
            $parent_tr = $('#category_' + $parent_id);
            $parent_tr.after($new_row);
          }
        },
        error: function(jqXHR, exception) {
          alert(I18n.t('erros'), I18n.t('created_error') + jqXHR.status, I18n.t('error'));
        }
      });
    });
  });

  $(".close").click(function(e) {
    $('#modal-new').hide();
  });
  $('#btn-new-product').click(function(e) {
    e.preventDefault()
    $('#modal-new').css('display', 'block')
    $.ajax({
      dataType: 'html',
      url: 'products/new',
      method: 'get',
      success: function(data) {
        $('.modal-body').html(data)
      }
    });
    return false
  });

  delete_item('.btn-delete-category', 'category')

  $count = 0;

  $('body').on('click', '.add_fields', function(e) {
    e.preventDefault();
    $spec = $(this).attr('data-fields');
    if ($count < 4) {
      $('.spec').append($spec);
      $count += 1;
    } else {
      alert(I18n.t('maximum'));
      return;
    }
    return false;
  });

  $('body').on('click', '#remove_fields', function(e) {
    e.preventDefault();
    $fieldset = $(this).closest('fieldset')
    $fieldset.fadeOut(1000, function() {
      $fieldset.remove();
      $count -= 1;
    })
    return false;
  })

  var oldTimeout = '';
  clearTimeout(oldTimeout);
  oldTimeout = setTimeout(function() {
    $(".flash-text").fadeOut();
  }, 5000);

  lineChart.initialize();
});
