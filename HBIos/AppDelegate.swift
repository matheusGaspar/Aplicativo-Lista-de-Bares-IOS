//
//  AppDelegate.swift
//  HBIos
//
//  Created by Jonathan on 28/01/20.
//  Copyright © 2020 Hbsis. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder,UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        // Ponto de substituição para personalização após o lançamento do aplicativo.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Enviado quando o aplicativo está prestes a passar do estado ativo para o inativo. Isso pode ocorrer em certos tipos de interrupções temporárias (como uma chamada telefônica ou mensagem SMS) ou quando o usuário sai do aplicativo e inicia a transição para o estado de segundo plano.
        // Use este método para pausar tarefas em andamento, desativar temporizadores e invalidar retornos de chamada de renderização gráfica. Os jogos devem usar esse método para pausar o jogo.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use esse método para liberar recursos compartilhados, salvar dados do usuário, invalidar cronômetros e armazenar informações suficientes sobre o estado do aplicativo para restaurar seu aplicativo ao estado atual, caso seja finalizado posteriormente.
        // Se seu aplicativo oferecer suporte à execução em segundo plano, esse método será chamado em vez de applicationWillTerminate: quando o usuário sair.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
       
        // Chamado como parte da transição do plano de fundo para o estado ativo; aqui você pode desfazer muitas das alterações feitas ao inserir o plano de fundo.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
       // Reinicie as tarefas que foram pausadas (ou ainda não foram iniciadas) enquanto o aplicativo estava inativo. Se o aplicativo estava anteriormente em segundo plano, opcionalmente, atualize a interface do usuário.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
        // Chamado quando o aplicativo está prestes a terminar. Salve os dados, se apropriado. Veja também applicationDidEnterBackground :.
    }


}

