module PagesHelper
  def get_now_links(amount_code)
  	html = ""
  	if !user_signed_in?
      html += link_to "get now", new_user_registration_path
  	elsif current_user.is_user?
     return get_it_now_links(amount_code)
  		# html += "<a href='/users/list_caregiver?code=#{amount_code}'>get now</a>"
  	else
  		html += link_to "get now","#"
  	end
  	html.html_safe
  end

  def continue amount_code
    html = ""
    if !user_signed_in?
      html += link_to "Continue", new_user_registration_path,class: 'btn btn-new'
    elsif current_user.is_user?
      html += "<a href='/users/list_caregiver?code=#{amount_code}' class='btn btn-new'>Continue</a>"
    else
      html += link_to "get now","#"
    end
    html.html_safe
  end 


  def get_now_links_modal(amount_code)
    html = ""
    if !user_signed_in?
      html += link_to "continue", new_user_registration_path
    elsif current_user.is_user?
      html += "<a href='/users/list_caregiver?code=#{amount_code}'>continue</a>"
    else
      html += link_to "continue","#"
    end

    html1 = "<button class='myBtn'>get now</button>
      <div id='myModal1' class='modal'>
        <div class='modal-content'>
        <span class='close'>&times;</span>
        <p>"+html+"</p>
      </div>
    </div>"

    html1.html_safe
  end


  def get_it_now_links code
    html= "<a data-toggle='modal' href='##{code}' class='btn btn-primary'>Get Now</a>"
    return html.html_safe
  end


  def all_modal
    return entry_level+exprience_caregiver+specialized_caregiver+qualified_caregiver

  end

  def entry_level 
    # html= "<a data-toggle='modal' href='##{code}' class='btn btn-primary'>Get Now</a>"
    html = "<div id='en' class='modal modal-wide fade'>
    <div class='modal-dialog'>
      <div class='modal-content'>
        <div class='modal-body'>
          <div class=' package-detail no-top'>
            <div >
              <div class='col-md-6'>
                <h2 class='tmargin50'>Entry Level Caregiver </h2>
                <h3>Rate <span>600/</span> day</h3>
                <p class='tmargin50'>What Entry Level Caregivers Do -</p>
                <ul>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Care to elderly and disabled clients as well as children </li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Assistance with grooming and bathing </li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Turning and positioning </li>
                  <li><i class='fa fa-arrow-right' aria-hidden='true'></i> Companionship and Conversation </li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Light housekeeping tasks and meal preparation </li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Feeding or assist with eating </li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Oral Medication </li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Assist with therapy at recommendation of medical professional</li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Skilled in running errands </li>
                  <li><i class='fa fa-arrow-right' aria-hidden='true'></i> Escort to appointments </li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Friendly attitude </li>
                  <li><i class='fa fa-arrow-right' aria-hidden='true'></i> Compassionate nature </li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Documentation, taking notes and reporting on patient wellbeing </li>
                </ul>
              </div>
              <div class='col-md-6'> <img src='/assets/home-care.jpg' width='100%'></div>
              <div class='clearfix'></div>
              <center>
                #{continue('en')}
                <button type='button' class='' data-dismiss='modal'>Close</button>
              </center>
            </div>
          </div>
        </div>
      </div>
      <!-- /.modal-content --> 
    </div>
    <!-- /.modal-dialog --> 
  </div>"
  return html.html_safe

  end
  
  def exprience_caregiver 
  # html= "<a data-toggle='modal' href='##{code}' class='btn btn-primary'>Get Now</a>"
  html = "<div id='ex' class='modal modal-wide fade'>
    <div class='modal-dialog'>
      <div class='modal-content'>
        <div class='modal-body'>
          <div class=' package-detail no-top'>
            <div >
              <div class='col-md-6'>
                <h2 class='tmargin50'>Experienced Caregiver </h2>
                <h3>Rate <span>900/</span> day</h3>
                <p class='tmargin50'>What Experienced Caregivers Do -</p>
                <ul>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Specialty care for Cancer care, Dementia, Parkinson's, Alzheimer's, Diabetic care, Stroke/Paralysis</li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Bedsore care </li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Assistance with Physiotherapy & Simple Massage </li>
                  <li><i class='fa fa-arrow-right' aria-hidden='true'></i> Pain Management </li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Fluid Management,</li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Monitor patient medications and update health charts </li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Assistance with grooming and bathing</li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Companionship and Conversation
                    Escort to appointments </li>
                </ul>
              </div>
              <div class='col-md-6'> <img src='/assets/2.jpg' width='100%'></div>
              <div class='clearfix'></div>
              <center>
                #{continue('ex')}
                <button type='button' class='' data-dismiss='modal'>Close</button>
              </center>
            </div>
          </div>
        </div>
      </div>
      <!-- /.modal-content --> 
    </div>
    <!-- /.modal-dialog --> 
  </div>"
  return html.html_safe
  end

  def specialized_caregiver 
   # html= "<a data-toggle='modal' href='##{code}' class='btn btn-primary'>Get Now</a>"
   html = "<div id='sc' class='modal modal-wide fade'>
    <div class='modal-dialog'>
      <div class='modal-content'>
        <div class='modal-body'>
          <div class=' package-detail no-top'>
            <div >
              <div class='col-md-6'>
                <h2 class='tmargin50'>Specialized Caregiver </h2>
                <h3>Rate <span>1200/</span> day</h3>
                <p class='tmargin50'>What Specialized Caregivers Do -</p>
                <ul>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Tracheostomy care </li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Colostomy care </li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Fluid Management </li>
                  <li><i class='fa fa-arrow-right' aria-hidden='true'></i> Respiratory management </li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Prevention of thrombosis </li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Medication Adherence </li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Wound care</li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Bladder wash </li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Stomach wash </li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Post Cancer Surgery care </li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Assistance with grooming and bathing </li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Companionship and Conversation </li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Escort to appointments </li>
                </ul>
              </div>
              <div class='col-md-6'> <img src='/assets/wound-management.jpg' width='100%'></div>
              <div class='clearfix'></div>
              <center>
                #{continue('sc')}
                <button type='button' class='' data-dismiss='modal'>Close</button>
              </center>
            </div>
          </div>
        </div>
      </div>
      <!-- /.modal-content --> 
    </div>
    <!-- /.modal-dialog --> 
  </div>"
  return html.html_safe
  end

  def qualified_caregiver 
  # html= "<a data-toggle='modal' href='##{code}' class='btn btn-primary'>Get Now</a>"
  html = "<div id='qn' class='modal modal-wide fade'>
    <div class='modal-dialog'>
      <div class='modal-content'>
        <div class='modal-body'>
          <div class=' package-detail no-top'>
            <div >
              <div class='col-md-6'>
                <h2 class='tmargin50'>Qualified Nurses </h2>
                <h3>Rate <span>2400/</span> day</h3>
                <p class='tmargin50'>What Qualified Caregivers Do -</p>
                <ul>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Monitor Pulse</li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Monitor Blood Pressure </li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Monitor Diet </li>
                  <li><i class='fa fa-arrow-right' aria-hidden='true'></i> Administer Medication S </li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Monitor Sugar levels </li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Measure Urine out put </li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> IV fluid administration </li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Urinary catheterization </li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Foley's (Nasogastric tube insertion) </li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> IM injections </li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Bed Sore cleaning </li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Assistance with grooming and bathing </li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Companionship and Conversation </li>
                  <li> <i class='fa fa-arrow-right' aria-hidden='true'></i> Escort to appointments </li>
                </ul>
              </div>
              <div class='col-md-6'> <img src='/assets/high_blood.jpg' width='100%'></div>
              <div class='clearfix'></div>
              <center>
                #{continue('qn')}
                <button type='button' class='' data-dismiss='modal'>Close</button>
              </center>
            </div>
          </div>
        </div>
      </div>
      <!-- /.modal-content --> 
    </div>
    <!-- /.modal-dialog --> 
  </div>"
  return html.html_safe
  end












end
