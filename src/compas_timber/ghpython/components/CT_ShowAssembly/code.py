from compas.artists import Artist
from ghpythonlib.componentbase import executingcomponent as component
from Grasshopper.Kernel.GH_RuntimeMessageLevel import Warning


class ShowAssembly(component):
    def RunScript(self, Assembly):
        if not Assembly:
            self.AddRuntimeMessage(Warning, "Input parameter Assembly failed to collect data")
            return
        Assembly = Assembly.copy()  # we're gonna be making changes to upstream objects

        Geometry = []
        Errors = []
        for beam in Assembly.beams:
            Geometry.append(Artist(beam.get_geometry(True)).draw())

        return Geometry
