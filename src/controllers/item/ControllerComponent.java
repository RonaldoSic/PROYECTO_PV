package controllers.item;

import com.jfoenix.controls.JFXButton;
import com.jfoenix.controls.JFXPasswordField;
import com.jfoenix.controls.JFXProgressBar;
import com.jfoenix.controls.JFXTextField;
import controllers.LoginController;
import controllers.ScreenController.ImplementsU.ControlledScreen;
import controllers.ScreenController.ScreensController;
import javafx.beans.InvalidationListener;
import javafx.beans.binding.Bindings;
import javafx.collections.ListChangeListener;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyEvent;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import models.User;
import navigator.ViewNavigator;
import utils.CreateThread;
import utils.ParseEmail;

import java.net.URL;
import java.util.ResourceBundle;
import java.util.Timer;

public class ControllerComponent implements Initializable, ControlledScreen {
    public Button btnForgot;
    public JFXProgressBar statusProgess;
    public JFXTextField txtUsername;
    public JFXPasswordField txtPassword;
    public Label lblErrors;
    public JFXButton btnSignin;
    public VBox VboxD;

    ScreensController myController;

    @FXML
    void nextPane(ActionEvent event)  {
        if(event.getSource() == btnForgot) {
            myController.setScreen(LoginController.screen2ID);
        }
    }
    User user;
    String status = "";
    public static boolean admin = false;
    @FXML
    public void handleButtonAction(MouseEvent event){
        //if(event.getSource() == btnSignin){
         // logIn();
       //}
       ViewNavigator.loadVista(ViewNavigator.HOME);
    }

   // public void handleButtonActionKey(KeyEvent keyEvent) {
     //   if(keyEvent.getCode().equals(KeyCode.ENTER)){
            //if(logIn().equals("Success")) {
            //  ViewNavigator.loadVista(ViewNavigator.HOME);
            //code = 1;
            //}
       // }
    //}

    private void logIn() {

        String email = txtUsername.getText();
        String password = txtPassword.getText();
        ParseEmail validate = new ParseEmail();

        if(!validate.isValid(email)&&!password.isEmpty()){
            setLblError(Color.TOMATO, "Usuario no valido");
            status = "Error";
        }
        if( password.isEmpty() && !email.isEmpty() ){
            setLblError(Color.TOMATO, "Ingrese una contraseña valida");
            status = "Error";
        }
        if(email.isEmpty() && password.isEmpty() ){
            setLblError(Color.GREEN, "Campos vacios");
            status = "Error";
        }if(!email.isEmpty() && !password.isEmpty()) {

            CreateThread task = new CreateThread(txtUsername.getText(), txtPassword.getText());
            new Thread(task).start();

            task.setOnRunning(workerStateEvent -> {
                statusProgess.setVisible(true);
                btnSignin.setDisable(true);
            });
            task.setOnSucceeded(workerStateEvent -> {
                btnSignin.setDisable(false);
                statusProgess.setVisible(false);
                user = task.getUserAux();

                if(user == null){
                    status = "Error";
                    setLblError(Color.TOMATO, "Usuario invalido");
                }else if(user!= null){
                    status="Success";
                    setLblError(Color.GREEN,"Login success...");
                    if (user.getAdmin().equals("admin")){
                        admin = true;
                    }
                    ViewNavigator.loadVista(ViewNavigator.HOME);
                }
            });
        }

    }

    private void setLblError(Color color, String text) {
        lblErrors.setTextFill(color);
        lblErrors.setText(text);
    }

    @Override
    public void setScreenParent(ScreensController screenPage) {
        myController = screenPage;
    }

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        //TasKT taskTime = new TasKT(btnSignin);
        //Timer temporizador = new Timer();
        //Integer segundos = 2;
        // temporizador.scheduleAtFixedRate(taskTime, 0, 1000*segundos);

    }

}
