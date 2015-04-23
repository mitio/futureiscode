ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    columns do
      column do
        panel 'Училища' do
          stats = {
            'Активни и участващи училища' => School.participating.up_to_date.count,
            'Всички участващи училища'    => School.participating.count,
            'Остарели участващи училища'  => School.participating.outdated.count,
            'Отказали се училища'         => School.not_participating.count,
            'Всички училища'              => School.count,
          }

          stats.each do |label, value|
            h2 "#{label}: <strong>#{value}</strong>".html_safe
          end
        end
      end

      column do
        panel 'Лектори и събития' do
          stats = {
            'Регистрирани лектори' => Speaker.count,
            'Фирми'                => Company.count,
            'Одобрени събития'     => Event.approved.count,
            'Чакащи събития'       => Event.pending.count,
            'Всички събития'       => Event.count,
          }

          stats.each do |label, value|
            h2 "#{label}: <strong>#{value}</strong>".html_safe
          end
        end
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
