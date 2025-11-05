//
//  ContactsUtil.swift
//  leaploan
//
//  Created by hekang on 2025/11/5.
//

import ContactsUI
import Contacts
import UIKit

struct ContactModel: Codable {
    var unmalted: String
    var disensure: String
}

class ContactsUtil: NSObject {
    
    // MARK: - 对外公开方法（建议使用这两个入口）
    
    /// 获取单个联系人（带权限拦截 + 系统选择器）
    static func selectOneContact(completion: @escaping (ContactModel?) -> Void) {
        checkPermission { allowed in
            guard allowed else {
                completion(nil)
                return
            }
            presentContactPicker(completion: completion)
        }
    }
    
    
    /// 获取所有联系人（后台返回数组） - 已处理拼接
    static func getAllContacts(completion: @escaping ([ContactModel]) -> Void) {
        checkPermission { allowed in
            guard allowed else {
                completion([])
                return
            }
            
            DispatchQueue.global().async {
                let contacts = fetchAllContacts()
                DispatchQueue.main.async {
                    completion(contacts)
                }
            }
        }
    }
    
    
    // MARK: - 内部实现部分
    
    /// 权限检查与处理
    private static func checkPermission(completion: @escaping (Bool) -> Void) {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        
        switch status {
        case .authorized:
            completion(true)
            
        case .notDetermined:
            CNContactStore().requestAccess(for: .contacts) { granted, _ in
                DispatchQueue.main.async {
                    if granted {
                        completion(true)
                    } else {
                        showPermissionAlert()
                        completion(false)
                    }
                }
            }
            
        case .denied, .restricted:
            showPermissionAlert()
            completion(false)
            
        case .limited:
            // iOS17+ 部分授权也弹窗
            showPermissionAlert()
            completion(false)
            
        @unknown default:
            showPermissionAlert()
            completion(false)
        }
    }
    
    
    /// 获取所有联系人数据
    private static func fetchAllContacts() -> [ContactModel] {
        var result: [ContactModel] = []
        let store = CNContactStore()
        
        let keys = [
            CNContactGivenNameKey,
            CNContactFamilyNameKey,
            CNContactPhoneNumbersKey
        ] as [CNKeyDescriptor]
        
        let request = CNContactFetchRequest(keysToFetch: keys)
        
        do {
            try store.enumerateContacts(with: request) { contact, _ in
                let name = contact.givenName + " " + contact.familyName
                
                let disensure = contact.phoneNumbers.map { $0.value.stringValue }
                    .joined(separator: ",")
                
                result.append(ContactModel(unmalted: name, disensure: disensure))
            }
        } catch {
            print("获取通讯录失败：\(error)")
        }
        
        return result
    }
    
    
    /// 弹系统联系人选择器
    private static func presentContactPicker(completion: @escaping (ContactModel?) -> Void) {
        let picker = CNContactPickerViewController()
        picker.delegate = ContactPickerDelegate.shared
        ContactPickerDelegate.shared.completion = completion
        
        DispatchQueue.main.async {
            guard let vc = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController else {
                completion(nil)
                return
            }
            vc.present(picker, animated: true)
        }
    }
    
    
    /// 权限提醒弹窗
    private static func showPermissionAlert() {
        DispatchQueue.main.async {
            
            guard let vc = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController else { return }
            
            let alert = UIAlertController(
                title: "无法访问通讯录",
                message: "请前往设置开启通讯录权限以使用此功能。",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "取消", style: .cancel))
            alert.addAction(UIAlertAction(title: "去设置", style: .default, handler: { _ in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }))
            vc.present(alert, animated: true)
        }
    }
}


class ContactPickerDelegate: NSObject, CNContactPickerDelegate {
    
    static let shared = ContactPickerDelegate()
    var completion: ((ContactModel?) -> Void)?
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let name = contact.givenName + " " + contact.familyName
        let disensure = contact.phoneNumbers.map { $0.value.stringValue }
            .joined(separator: ",")
        
        completion?(ContactModel(unmalted: name, disensure: disensure))
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        completion?(nil)
    }
}
