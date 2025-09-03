# Musterlösung

# Benötigten Module laden #####################
import pandas as pd
import geopandas as gpd
from matplotlib import pyplot as plt
###############################################

# Notwendige Functions definieren #############
def offset_coordinate(old, distance = 100):
    import random
    new = old + random.normalvariate(0, distance)
    return new
###############################################

# Daten Importieren ###########################
zeckenstiche_full = pd.read_csv("zeckenstiche_full.csv")
wald = gpd.read_file("wald.gpkg")
###############################################

# For Loops erstellen #########################
radien = [10, 100, 1000]

for radius in radien:
    im_wald_list = []
    
    for _ in range(50):
        x_sim = zeckenstiche_full["x"].apply(offset_coordinate, distance = radius)
        y_sim = zeckenstiche_full["y"].apply(offset_coordinate, distance = radius)
            
        geom = gpd.points_from_xy(x_sim, y_sim)
        zeckenstiche_gpd = gpd.GeoDataFrame(zeckenstiche_full, geometry = geom, crs = 2056) 
        zeckenstiche_join = gpd.sjoin(zeckenstiche_gpd, wald)

        im_wald = sum(zeckenstiche_join["Wald_text"] == "ja") / len(zeckenstiche_join["Wald_text"])

        im_wald_list.append(im_wald)

    plt.figure()
    pd.Series(im_wald_list).plot(kind="box")
    plt.title(f"Radius {radius}")

plt.show()    
###############################################