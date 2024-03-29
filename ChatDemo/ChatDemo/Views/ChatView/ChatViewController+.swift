import UIKit
import PhotosUI

import MessageKit
import InputBarAccessoryView

extension ChatViewController: MessagesDataSource {
    var currentSender: MessageKit.SenderType {
        return Sender(senderId: user.uid, displayName: user.fullName)
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        messages.count
    }
    
    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let name = message.sender.displayName
        return NSAttributedString(string: name, attributes: [.font: UIFont.preferredFont(forTextStyle: .caption1),
                                                             .foregroundColor: UIColor(white: 0.3, alpha: 1)
        ])
    }
    
}

extension ChatViewController: MessagesLayoutDelegate {
    // 아래 여백
    func cellBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return CGFloat(10)
    }
    
    // 말풍선 위 이름 나오는 곳의 Height
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 20
    }
}

// 상대방이 보낸 메시지, 내가 보낸 메시지를 구분하여 색상과 모양 지정
extension ChatViewController: MessagesDisplayDelegate {
    // 말풍선의 배경 색상
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .primary : .incomingMessageBackground
    }
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .black : .white
    }
    
    // 말풍선의 꼬리 모양 방향
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        let cornerDirection: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(cornerDirection, .curved)
    }
}

extension ChatViewController: MessageCellDelegate {
    func didTapImage(in cell: MessageCollectionViewCell) {
        print(#function)
        print("didTapMessage")
        guard let indexPath = messagesCollectionView.indexPath(for: cell),
              let messagesDataSource = messagesCollectionView.messagesDataSource else { return }
        let message = messagesDataSource.messageForItem(at: indexPath, in: messagesCollectionView)
        switch message.kind {
        case .photo(let photoItem):
            print("DEBUG - Message in a photo")
            if let image = photoItem.image {
                // cell의 위치정보
                let cellOriginFrame = cell.superview?.convert(cell.frame, to: nil)
                let cellOriginPoint = cellOriginFrame?.origin
                
                
                // Transition 설정
                imageTransition.setPoint(point: cellOriginPoint)
                imageTransition.setFrame(frame: cellOriginFrame)
                
                let imageMessageViewController = ImageMessageViewController()
                imageMessageViewController.image = image
                imageMessageViewController.transitioningDelegate = self
                imageMessageViewController.modalPresentationStyle = .custom
                
                present(imageMessageViewController, animated: true)
            }
        default:
            print("DEBUG - Message is not a photo")
            break
        }
    }
}

extension ChatViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return imageTransition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DisMissAnim()
    }
}

extension ChatViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        let message = Message(user: user, content: text)
        if self.isNewChat {
            print("isNewChat = \(self.isNewChat)")
            channelAPI.createChannel(channelId: channel.id!, currentUser: self.user, toUser: self.toUser!) {
                
                self.chatAPI.save(message) { [weak self] error in
                    
                    if let error = error {
                        print("DEBUG- inputBar Error: \(error.localizedDescription)")
                        return
                    }
                    guard let self = self else { return }
                    self.isNewChat = false
                    self.messagesCollectionView.scrollToLastItem(animated: false)
                    self.channelAPI.updateChannelInfo(currentUser: user, toUser: toUser!, channelId: channel.id!, message: message)
                    NotiManager.shared.pushNotification(channel: channel, content: text, fcmToken: toUser!.fcmToken, from: user)
                }
            }
        } else {
            print("isNewChat = \(self.isNewChat)")
            
            chatAPI.save(message) { [weak self] error in
                
                if let error = error {
                    print("DEBUG- inputBar Error: \(error.localizedDescription)")
                    return
                }
                guard let self = self else { return }
                //            self.isNewChat = false
                self.messagesCollectionView.scrollToLastItem(animated: false)
                self.channelAPI.updateChannelInfo(currentUser: user, toUser: toUser!, channelId: channel.id!, message: message)
                NotiManager.shared.pushNotification(channel: channel, content: text, fcmToken: toUser!.fcmToken, from: user)
            }
        }
        inputBar.inputTextView.text.removeAll()
    }
}

extension ChatViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        if let itemProvider = itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                if let image = image as? UIImage {
                    self.sendPhoto(image)
                }
            }
        }
    }
    
    private func sendPhoto(_ image: UIImage) {
        // TODO: - 첫 메시지인경우 채팅방 생성 로직 추가
        isSendingPhoto = true
        StorageAPI.uploadImage(image: image, channel: channel) { [weak self] url in
            guard let self = self, let url = url else { return }
            self.isSendingPhoto = false
            var message = Message(user: user, image: image)
            message.downloadURL = url
            self.chatAPI.save(message)
            self.messagesCollectionView.scrollToLastItem(animated: false)
            self.channelAPI.updateChannelInfo(currentUser: user, toUser: toUser!, channelId: channel.id!, message: message)
            NotiManager.shared.pushNotification(channel: channel, content: ("사진"), fcmToken: toUser!.fcmToken, from: user)
            
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: PHPickerViewController) {
        picker.dismiss(animated: true)
    }
}
