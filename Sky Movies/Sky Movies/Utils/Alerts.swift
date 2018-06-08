//
//  Alerts.swift
//  Sky Movies
//
//  Created by Kesley Ribeiro on 8/Jun/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import Foundation
import SwiftMessages

class Alerts {
    
     /* Método que mostra um alerta personalizado ao usuário
        - 1 vai mostrar alerta do tipo warning
        - 2 vai mostrar alerta do tipo error
        - 3 vai mostrar alerta do tipo success
     */

    func exibirAlertaPersonalizado(_ mensagem: String, tipoAlerta: Int) {

        let view = MessageView.viewFromNib(layout: .cardView)
        
        // Add a drop shadow.
        view.configureDropShadow()
        
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .center
        config.dimMode = .gray(interactive: true)

        // Define por quanto tempo o alerta aparece na tela
        config.duration = .seconds(seconds: 4)

        switch tipoAlerta {

        case 1:

            // Define o tipo e o estilo do alerta
            view.configureTheme(.warning, iconStyle: .light)
            
            // Define o título do alerta
            view.configureContent(title: "Atenção!", body: mensagem)
            view.button?.setTitle("OK", for: .normal)

            // Exibe o alerta
            SwiftMessages.show(config: config, view: view)

        case 2:

            // Define o tipo e o estilo do alerta
            view.configureTheme(.error, iconStyle: .light)
            
            // Define o título do alerta
            view.configureContent(title: "Erro!", body: mensagem)
            view.button?.setTitle("OK", for: .normal)
            
        case 3:

            // Define o tipo e o estilo do alerta
            view.configureTheme(.success, iconStyle: .light)
            
            view.configureContent(title: "Sucesso!", body: mensagem)
            view.button?.setTitle("😃", for: .normal)
            
        default: break

        }
        
        view.button?.addTarget(self, action: #selector(Alerts.esconderBotao), for: .touchUpInside)
        
        // Exibe o alerta
        SwiftMessages.show(config: config, view: view)
    }

    @objc func esconderBotao() {
        SwiftMessages.hide()
    }
}

