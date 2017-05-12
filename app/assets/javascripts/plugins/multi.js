
$(document).ready(function () {
    $('#new_patient fieldset:first').fadeIn('slow');
    $('#new_patient input').on('focus', function () {
        $(this).removeClass('input-error');
		 });
     $('#new_patient #tags1').on('focus', function () {
        $(this).removeClass('input-error');
    });
    // next step
    $('#new_patient .btn-next').on('click', function () {
        var parent_fieldset = $(this).parents('fieldset');
        var next_step = true;
        parent_fieldset.find('#patient_first_name, #patient_last_name').each(function () {
            if ($(this).val() == "") {
                $(this).addClass('input-error');
                next_step = false;
            } else {
                $(this).removeClass('input-error');
            }
        });

        if (next_step) {
            parent_fieldset.fadeOut(400, function () {
                $(this).next().fadeIn();
            });
        }

    });

    // previous step
    $('#new_patient .btn-previous').on('click', function () {
        $(this).parents('fieldset').fadeOut(400, function () {
            $(this).prev().fadeIn();
        });
    });

    // submit
    // $('#new_patient').on('submit', function (e) {

    //     $(this).find('input[type="text"],input[type="email"],#tags1').each(function () {
    //         if ($(this).val() == "") {
    //             e.preventDefault();
    //             $(this).addClass('input-error');
    //         } else {
    //             $(this).removeClass('input-error');
    //         }
    //     });

    // });

   
});