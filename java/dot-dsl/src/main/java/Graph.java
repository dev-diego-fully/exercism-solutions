import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Collection;

public class Graph {

    private final List<Node> nodes = new LinkedList<Node>();
    private final List<Edge> edges = new LinkedList<Edge>();
    private final Map<String, String> attributes;

    public Graph() {
        this.attributes = new HashMap();
    }

    public Graph(Map<String, String> attributes) {
        this.attributes = new HashMap(attributes);
    }

    public Map<String, String> getAttributes() {
        return new HashMap(this.attributes);
    }

    public Collection<Node> getNodes() {
        return new LinkedList(this.nodes);
    }

    public Collection<Edge> getEdges() {
        return new LinkedList(this.edges);
    }

    public Graph node(String name) {
        this.nodes.add(new Node(name));
        return this;
    }

    public Graph node(String name, Map<String, String> attributes) {
        this.nodes.add(new Node(name, attributes));
        return this;
    }

    public Graph edge(String start, String end) {
        this.edges.add(new Edge(start, end));
        return this;
    }

    public Graph edge(String start, String end, Map<String, String> attributes) {
        this.edges.add(new Edge(start, end, attributes));
        return this;
    }

    
}
