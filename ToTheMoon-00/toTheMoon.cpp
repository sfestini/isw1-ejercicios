#include <bits/stdc++.h>

using namespace std;

class brazoExcavador{
	public:

		brazoExcavador(){
			encendido = false;
		};

		int excavar(int dureza, int porosidad);	// 0 = suelo blando - 1 = suelo duro // 0 excavacion exitosa, cualquier otra cosa ERROR

	private:
		bool encendido;
		bool dirMotor;  	// 0 = subir - 1 = bajar
		bool sentidoGiro;	// 0 = anti-horario - 1 = horario
		bool pinza;			// 0 = abierta - 1 = cerrada
		int velMotor;



		void pisoDuro();
		void pisoBlando();
	
};

	int brazoExcavador::excavar(int dureza, int porosidad){
		//Inicio zona critica (de ser necesario, agregariamos locks)
		if(encendido) return 1;

		if(dureza > porosidad) pisoDuro();
		else pisoBlando();
		
		//fin zona critica
		return 0;
	}

	void brazoExcavador::pisoBlando(){
		// Seteamos valores del motor para bajar
		velMotor = 100;
		dirMotor = 1;
		sentidoGiro = 0;
		
		// Encendemos el motor
		encendido = true;

		// Esperamos los 5 minutos
		this_thread::sleep_for(chrono::seconds(300));

		// Apagamos el motor
		encendido = false;

		// Tomamos la muestra
		pinza = true;

		// Seteamos los nuevos valores del motor para subir
		dirMotor = 0;
		sentidoGiro = 1;
		encendido = true;

		// Esperamos los 5 minutos
		this_thread::sleep_for(chrono::seconds(300));

		// Apagamos el motor y soltamos la muestra
		encendido = false;
		pinza = false;
	}

	void brazoExcavador::pisoDuro(){
		// Seteamos valores del motor para bajar
		velMotor = 150;
		dirMotor = 1;
		sentidoGiro = 1;
		
		// Encendemos el motor
		encendido = true;

		// Esperamos los 10 minutos
		this_thread::sleep_for(chrono::seconds(600));

		// Apagamos el motor
		encendido = false;

		// Tomamos la muestra
		pinza = true;

		// Seteamos los nuevos valores del motor para subir
		dirMotor = 0;
		sentidoGiro = 0;
		encendido = true;

		// Esperamos los 10 minutos
		this_thread::sleep_for(chrono::seconds(600));

		// Apagamos el motor y soltamos la muestra
		encendido = false;
		pinza = false;
	}


int main(){
	return 0;
}

