import QtQuick
import qs.Ui

BarWidget {
  id: root
  moduleName: "io.github.s3pp3ku.runner"

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  WidgetButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: "%"
    labelVisible: true
    onPressed: function(mouseButton) {
      if (mouseButton === Qt.LeftButton && root.bar)
        root.bar.run("omarchy-runner")
    }
  }
}
