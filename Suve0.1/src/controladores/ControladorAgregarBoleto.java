package controladores;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.ArrayList;
import java.util.GregorianCalendar;
import java.util.List;

import dao.*;
import datos.*;
import negocio.*;

/**
 * Servlet implementation class ControladorAgregarBoleto
 */
@WebServlet("/ControladorAgregarBoleto")
public class ControladorAgregarBoleto extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ControladorAgregarBoleto() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		System.out.println("Entras1");
		procesaSolicitud(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("Entras2");
		procesaSolicitud(request, response);
	}
	
	
	
	protected void procesaSolicitud(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int numSerieTarjeta = Integer.parseInt(request.getParameter("numSerieTarjeta"));
		int numSerieLectora =Integer.parseInt(request.getParameter("numSerieLectora"));
		TarjetaDao tardao = new TarjetaDao();
		System.out.println("Entras");
		AdminDeLectoras manejador = new AdminDeLectoras();
		
		GregorianCalendar fechaHora = new GregorianCalendar(Integer.parseInt(request.getParameter("fanio")), 
															Integer.parseInt(request.getParameter("fmes")), 
															Integer.parseInt(request.getParameter("fdia")), 
															Integer.parseInt(request.getParameter("fhora")), 
															Integer.parseInt(request.getParameter("fminuto")), 
															Integer.parseInt(request.getParameter("fsegundo")));
		
		if(request.getParameter("tipoTransporte").equals("Colectivo")) {
			//En estacion voy a tener el tramo
			TramoColectivoDao tdao = new TramoColectivoDao();
			List<TramoColectivo> list = tdao.traerTramoColectivo();
			TramoColectivo tramo = null;
			for(TramoColectivo ttemp:list) {
				System.out.println(ttemp.toString());
				if( request.getParameter("estacion").equals(ttemp.toString())){
					tramo = ttemp;
				}
			}
			if(tramo==null) {
				System.out.println("Taradooo EHhh");
			}
			else {
				try {
					System.out.println("Agrego un boleto de colectivo con Tramo:" + tramo.getSeccionViaje().getMonto());
					LectoraDao lecdao = new LectoraDao();
					Lectora l = lecdao.traerLectoraColectivo(numSerieLectora);
					System.out.println("La nueva prueba1");
					manejador.agregarBoleto(l.getNumeroSerieLectora(),tardao.traerTarjeta(numSerieTarjeta), new GregorianCalendar(), tramo);
					
				} catch (Exception e) {
					System.out.println("Puto " + e);
				}
			}
		}
		else {
			try {
				System.out.println("Agrego unboleto de TS");
				manejador.agregarBoleto(numSerieLectora,tardao.traerTarjeta(numSerieTarjeta), fechaHora);
				System.out.println("Y LO AGREGA TS");
			} catch (Exception e){
				System.out.println(e);
			}
		}
		
		response.setStatus(200);
		System.out.println(Funciones.TraeFechaYHora(fechaHora));
	}
	
	

}
