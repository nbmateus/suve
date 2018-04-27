package datos;

public class Estacion {
	private long idEstacion;
	private Transporte transporte;
	private String nombre;
	
	
	public Estacion() {}
	public Estacion(Transporte transporte, String nombre) {
		super();
		this.transporte = transporte;
		this.nombre = nombre;
	}
	
	
	public long getIdEstacion() {
		return idEstacion;
	}
	protected void setIdEstacion(long idEstacion) {
		this.idEstacion = idEstacion;
	}
	public Transporte getTransporte() {
		return transporte;
	}
	public void setTransporte(Transporte transporte) {
		this.transporte = transporte;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	
	
	@Override
	public String toString() {
		return "Estacion [idEstacion=" + idEstacion + ", transporte=" + transporte + ", nombre=" + nombre + "]";
	}
}
