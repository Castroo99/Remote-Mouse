from ctypes import cast, POINTER
from comtypes import CLSCTX_ALL
from pycaw.pycaw import AudioUtilities, IAudioEndpointVolume

def change_volume(delta):
    devices = AudioUtilities.GetSpeakers()
    interface = devices.Activate(IAudioEndpointVolume._iid_, CLSCTX_ALL, None)
    volume = cast(interface, POINTER(IAudioEndpointVolume))
    current = volume.GetMasterVolumeLevelScalar()
    volume.SetMasterVolumeLevelScalar(min(max(current + delta, 0.0), 1.0), None)