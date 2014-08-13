require 'spec_helper'

describe IconHelper do

  describe 'should render icon' do
    it 'for github' do
      icon = icon_for :github
      icon.should eq content_tag(:i, nil, class: 'fa fa-github fa-fw ')
    end

    it 'for github' do
      icon = icon_for :chart
      icon.should eq content_tag(:i, nil, class: 'fa fa-bar-chart-o fa-fw ')
    end

    it 'for list' do
      icon = icon_for :list
      icon.should eq content_tag(:i, nil, class: 'fa fa-list-ul fa-fw ')
    end

    it 'for clock' do
      icon = icon_for :clock
      icon.should eq content_tag(:i, nil, class: 'fa fa-clock-o fa-fw ')
    end

    it 'for commit log' do
      icon = icon_for :commit_log
      icon.should eq content_tag(:i, nil, class: 'fa fa-align-left fa-fw ')
    end

    it 'for dashboard' do
      icon = icon_for :dashboard
      icon.should eq content_tag(:i, nil, class: 'fa fa-dashboard fa-fw ')
    end

    it 'for upload' do
      icon = icon_for :upload
      icon.should eq content_tag(:i, nil, class: 'fa fa-upload fa-fw ')
    end

    it 'for right_angle' do
      icon = icon_for :right_angle
      icon.should eq content_tag(:i, nil, class: 'fa fa-angle-right fa-fw ')
    end

    it 'for caret_down' do
      icon = icon_for :caret_down
      icon.should eq content_tag(:i, nil, class: 'fa fa-caret-down fa-fw ')
    end

    it 'for user' do
      icon = icon_for :user
      icon.should eq content_tag(:i, nil, class: 'fa fa-user fa-fw ')
    end

    it 'for bell' do
      icon = icon_for :bell
      icon.should eq content_tag(:i, nil, class: 'fa fa-bell fa-fw ')
    end

    it 'for key' do
      icon = icon_for :key
      icon.should eq content_tag(:i, nil, class: 'fa fa-key fa-fw ')
    end

    it 'adds extra html class when given argument' do
      html_class = 'whatever'
      icon = icon_for :bell, html_class
      icon.should eq content_tag(:i, nil, class: 'fa fa-bell fa-fw whatever')
    end

    it 'raises error on unknown icon type' do
      expect { icon_for :non_existing_icon }.to raise_error
    end
  end

end
