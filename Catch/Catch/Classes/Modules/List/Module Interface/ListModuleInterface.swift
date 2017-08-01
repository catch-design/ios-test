//
//  ListModuleInterface.swift
//  Catch
//
//  Created by XiankunCheng on 1/08/17.
//  Copyright © 2017 Xiankun Cheng. All rights reserved.
//

import UIKit

protocol ListModuleInterface {
    func updateView()
    func toDetail(_ dataEntity: DataEntity, from sender: UIViewController)
}
