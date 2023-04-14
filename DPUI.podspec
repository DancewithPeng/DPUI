Pod::Spec.new do |spec|
  spec.name = "DPUI"
  spec.version = "1.2.0"
  spec.summary = "总结的UI开发套件，主要包含控件、扩展、工具"
  spec.description = <<-DESC
                         总结的UI开发套件，主要包含控件、扩展、工具，用于积累代码，提高开发效率
                      DESC
  spec.homepage = "https://github.com/DancewithPeng/DPUI.git"
  spec.license = { :type => "MIT", :file => "LICENSE" }
  spec.author = { "DancewithPeng" => "dancewithpeng@gmail.com" }

  spec.platform = :ios, "13.0"
  spec.swift_version = "5.7"
  spec.source = { :git => "https://github.com/DancewithPeng/DPUI.git", :tag => "#{spec.version}" }
  spec.source_files = "DPUI/DPUI.h"

  spec.subspec "Extensions" do |es|
    es.subspec "Namespace" do |ns|
      ns.source_files = "DPUI/Sources/Extensions/Extensions.swift"
    end

    es.subspec "VisiblePage" do |vs|
      vs.source_files = "DPUI/Sources/Extensions/VisiblePage.swift"

      vs.dependency "DPUI/Extensions/Namespace"
    end

    es.subspec "ChildPage" do |cs|
      cs.source_files = "DPUI/Sources/Extensions/ChildPage.swift"

      cs.dependency "DPUI/Extensions/Namespace"
    end

    es.subspec "HexColor" do |hs|
      hs.source_files = "DPUI/Sources/Extensions/HexColor.swift"

      hs.dependency "DPUI/Extensions/Namespace"
    end

    es.subspec "ConvenientGesture" do |cg|
      cg.source_files = "DPUI/Sources/Extensions/ConvenientGesture.swift"

      cg.dependency "DPUI/Extensions/Namespace"
    end
  end

  spec.subspec "Controls" do |cs|
    cs.subspec "ImageLayer" do |is|
      is.source_files = "DPUI/Sources/Controls/ImageLayer.swift"
    end

    cs.subspec "PalaceGridView" do |ps|
      ps.source_files = "DPUI/Sources/Controls/PalaceGridView.swift"

      ps.dependency "DPUI/Controls/ImageLayer"
    end
  end

  spec.module_map = false
end
