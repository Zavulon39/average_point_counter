class MeanMark {
    int mark;
    int createdAt = DateTime.now().millisecondsSinceEpoch;

    MeanMark (this.mark);
}

class WeightedMark {
    int mark;
    double coeff;
    int createdAt = DateTime.now().millisecondsSinceEpoch;

    WeightedMark (this.mark, this.coeff);
}