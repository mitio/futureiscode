ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t('active_admin.dashboard') } do
    div style: 'margin-bottom: 3em;' do
      stats = {
        'Участващи училища'    => School.where(confirmed_participation: true).count,
        'Всички училища'       => School.count,
        'Регистрирани лектори' => Speaker.count,
      }

      stats.each do |label, value|
        h2 "#{label}: <strong>#{value}</strong>".html_safe
      end
    end

    columns do
      column do
        panel 'Последни училища' do
          ul do
            School.last(5).map do |school|
              li link_to(school.name_with_location, admin_school_path(school))
            end
          end
        end
      end

      column do
        panel 'Последни лектори' do
          ul do
            Speaker.last(5).map do |speaker|
              li link_to(speaker.name, admin_speaker_path(speaker))
            end
          end
        end
      end
    end
  end
end
