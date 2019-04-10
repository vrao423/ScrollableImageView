import UIKit

class SpaceView: UIView {

    var expanded = false

    override init(frame: CGRect) {
        super.init(frame: .zero)

        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)

        button.setTitle("Expand", for: .normal)
        button.addTarget(self, action: #selector(toggleSpace), for: .touchUpInside)
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func toggleSpace(sender: UIButton) {
        expanded = !expanded
        sender.setTitle(expanded ? "Collapse" : "Expand", for: .normal)
        
        invalidateIntrinsicContentSize()
        self.superview!.setNeedsLayout()
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric,
                      height: (expanded ? 200.0 : 100.0))
    }
}
