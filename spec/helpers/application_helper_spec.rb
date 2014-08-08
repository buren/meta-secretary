require 'spec_helper'

describe ApplicationHelper do

  describe 'should render handlebar' do
    it 'with paragraph and ul tag' do
      rendered = render_handlebar '/dummy_path' do
        content_tag :p, nil
        content_tag :ul, nil
      end
      rendered.include?('<p>').should be_true
      rendered.include?('<ul>').should be_true
      rendered.include?('<script').should be_true
      rendered.include?('fa fa-spinner fa-spin fa-2x').should be_true
      rendered.include?('id=').should be_true
      rendered.include?('data-id=').should be_true
    end

    it 'with script tag' do
      rendered = render_handlebar '/dummy_path' do
        content_tag :p, nil
        content_tag :ul, nil
      end
      rendered.include?('<script').should be_true
      rendered.include?(MetaDefines::Handlebars::TARGET_CLASS).should be_true
    end

    it 'with handlebar HTML class' do
      rendered = render_handlebar '/dummy_path' do
        content_tag :p, nil
        content_tag :ul, nil
      end
      rendered.include?(MetaDefines::Handlebars::TARGET_CLASS).should be_true
    end

    it 'with font awesome spinner icon classes' do
      rendered = render_handlebar '/dummy_path' do
        content_tag :p, nil
        content_tag :ul, nil
      end
      rendered.include?('fa fa-spinner fa-spin fa-2x').should be_true
    end

    it 'with id attribute' do
      rendered = render_handlebar '/dummy_path' do
        content_tag :p, nil
        content_tag :ul, nil
      end
      rendered.include?('id=').should be_true
    end

    it 'with data-id attribute' do
      rendered = render_handlebar '/dummy_path' do
        content_tag :p, nil
        content_tag :ul, nil
      end
      rendered.include?('data-id=').should be_true
    end
  end

  describe 'it should render panel' do
    it 'with panel title' do
      panel_title = 'test-panel-title'
      rendered = render_panel panel_title, ''
      rendered.include?(panel_title).should be_true
    end

    it 'with panel body as argument' do
      panel_body  = 'test-panel-body'
      rendered = render_panel '', panel_body
      rendered.include?(panel_body).should be_true
    end

    it 'with panel body as block' do
      panel_body  = 'test-panel-body'
      rendered = render_panel '' do
        inner  = content_tag :p,  panel_body
        inner += content_tag :ul, nil
      end
      rendered.include?('<p>').should be_true
      rendered.include?('<ul>').should be_true
      rendered.include?(panel_body).should be_true
    end

    it 'with panel wrapper classes' do
      rendered = render_panel '', ''
      rendered.include?('panel panel-default').should be_true
    end

    it 'with panel title class' do
      rendered = render_panel '', ''
      rendered.include?('panel-heading').should be_true
    end

    it 'with panel body class' do
      rendered = render_panel '', ''
      rendered.include?('panel-body').should be_true
    end
  end

  describe 'should render timeline' do
    describe 'list' do
      it 'with correct HTML-tag' do
        rendered = render_timeline_list { }
        rendered.include?('<ul class="timeline">').should be_true
      end

      it 'with correct contents' do
        test_body = 'test-body'
        rendered = render_timeline_list { content_tag :li, test_body }
        rendered.include?(test_body).should be_true
      end
    end

    describe 'with timeline list item' do
      it 'with icon class option' do
        rendered = render_timeline_item('', '') {}
        rendered.include?('<i class="fa fa-upload fa-fw ">').should be_true
      end

      it 'with event_type class option' do
        rendered = render_timeline_item('', '') {}
        rendered.include?('class="timeline-badge success"').should be_true
        rendered = render_timeline_item('', '', event_type: 'test_event') {}
        rendered.include?('class="timeline-badge test_event"').should be_true
      end

      it 'with left class option' do
        rendered = render_timeline_item('', '') {}
        rendered.include?(MetaDefines::View::TIMELINE_INVERTED_LI).should be_false
        rendered = render_timeline_item('', '', left: false) {}
        rendered.include?(MetaDefines::View::TIMELINE_INVERTED_LI).should be_true
      end

      it 'with render_li option' do
        rendered = render_timeline_item('', '') {}
        rendered.include?('<li').should be_true
        rendered = render_timeline_item('', '', render_li: false) {}
        rendered.include?('<li').should be_false
      end

      it 'with correct contents title' do
        test_title = 'test-timeline-title'
        rendered = render_timeline_item(test_title, '') {}
        rendered.include?(test_title).should be_true
      end

      it 'with correct contents time' do
        test_time = '12:00'
        rendered = render_timeline_item('', test_time) {}
        rendered.include?('<small class="text-muted">').should be_true
        rendered.include?(content_tag(:i, nil, class: 'fa fa-clock-o fa-fw ')).should be_true
        rendered.include?(test_time).should be_true
      end

      it 'with correct contents body' do
        test_body = 'test-timeline-body'
        rendered = render_timeline_item('', '') { content_tag :p, test_body }
        rendered.include?(content_tag :p, test_body).should be_true
        rendered.include?(test_body).should be_true
      end

      it 'with timeline-panel wrapper class' do
        rendered = render_timeline_item('', '') {}
        rendered.include?('class="timeline-panel"').should be_true
      end

      it 'with timeline-panel title class' do
        rendered = render_timeline_item('', '') {}
        rendered.include?('class="timeline-heading"').should be_true
      end

      it 'with timeline-panel body class' do
        rendered = render_timeline_item('', '') {}
        rendered.include?('class="timeline-body"').should be_true
      end

      it 'with timeline-panel badge class' do
        rendered = render_timeline_item('', '') {}
        rendered.include?('class="timeline-badge success"').should be_true
      end
    end
  end

end
